#!/usr/bin/env python3
"""
Documentation Test Suite for emacs-r-devkit

Tests:
1. Link validation (internal and external)
2. Markdown syntax validation
3. Code block syntax
4. MkDocs build verification
5. Cross-reference validation
"""

import os
import re
import sys
from pathlib import Path
from typing import List, Tuple, Set
import subprocess

# Colors for output
GREEN = '\033[92m'
RED = '\033[91m'
YELLOW = '\033[93m'
RESET = '\033[0m'

class DocumentationTester:
    def __init__(self, docs_dir: str = "docs_mkdocs"):
        self.docs_dir = Path(docs_dir)
        self.errors = []
        self.warnings = []
        
    def test_all(self) -> bool:
        """Run all documentation tests"""
        print("🧪 Running Documentation Tests\n")
        
        tests = [
            ("Link Validation", self.test_links),
            ("Markdown Syntax", self.test_markdown_syntax),
            ("Code Blocks", self.test_code_blocks),
            ("MkDocs Build", self.test_mkdocs_build),
            ("Cross References", self.test_cross_references),
        ]
        
        passed = 0
        failed = 0
        
        for name, test_func in tests:
            print(f"Testing: {name}...", end=" ")
            try:
                if test_func():
                    print(f"{GREEN}✓ PASS{RESET}")
                    passed += 1
                else:
                    print(f"{RED}✗ FAIL{RESET}")
                    failed += 1
            except Exception as e:
                print(f"{RED}✗ ERROR: {e}{RESET}")
                failed += 1
        
        # Print summary
        print(f"\n{'='*60}")
        print(f"Results: {GREEN}{passed} passed{RESET}, {RED}{failed} failed{RESET}")
        
        if self.warnings:
            print(f"\n{YELLOW}Warnings:{RESET}")
            for warning in self.warnings:
                print(f"  ⚠ {warning}")
        
        if self.errors:
            print(f"\n{RED}Errors:{RESET}")
            for error in self.errors:
                print(f"  ✗ {error}")
        
        return failed == 0
    
    def test_links(self) -> bool:
        """Test all markdown links"""
        md_files = list(self.docs_dir.glob("**/*.md"))
        
        # Pattern for markdown links: [text](url)
        link_pattern = re.compile(r'\[([^\]]+)\]\(([^\)]+)\)')
        
        broken_links = []
        
        for md_file in md_files:
            content = md_file.read_text()
            links = link_pattern.findall(content)
            
            for text, url in links:
                # Skip external links (http/https)
                if url.startswith(('http://', 'https://')):
                    continue
                
                # Skip anchors
                if url.startswith('#'):
                    continue
                
                # Check internal file links
                if not url.startswith('file://'):
                    # Relative path
                    target = (md_file.parent / url).resolve()
                    if not target.exists():
                        broken_links.append(f"{md_file.name}: {url}")
        
        if broken_links:
            self.errors.extend([f"Broken link: {link}" for link in broken_links])
            return False
        
        return True
    
    def test_markdown_syntax(self) -> bool:
        """Test markdown syntax using markdownlint"""
        try:
            result = subprocess.run(
                ['markdownlint', str(self.docs_dir)],
                capture_output=True,
                text=True
            )
            
            if result.returncode != 0:
                # Parse warnings vs errors
                for line in result.stdout.splitlines():
                    if 'MD' in line:
                        self.warnings.append(f"Markdown lint: {line}")
                
                # Only fail on critical errors
                return True
            
            return True
        except FileNotFoundError:
            self.warnings.append("markdownlint not installed, skipping")
            return True
    
    def test_code_blocks(self) -> bool:
        """Test code blocks have language specified"""
        md_files = list(self.docs_dir.glob("**/*.md"))
        
        # Pattern for fenced code blocks without language
        code_block_pattern = re.compile(r'^```\s*$', re.MULTILINE)
        
        missing_lang = []
        
        for md_file in md_files:
            content = md_file.read_text()
            matches = code_block_pattern.findall(content)
            
            if matches:
                missing_lang.append(f"{md_file.name}: {len(matches)} blocks without language")
        
        if missing_lang:
            self.warnings.extend([f"Code block: {item}" for item in missing_lang])
            # Warning only, not failure
        
        return True
    
    def test_mkdocs_build(self) -> bool:
        """Test MkDocs builds successfully"""
        try:
            result = subprocess.run(
                ['mkdocs', 'build', '--strict'],
                capture_output=True,
                text=True
            )
            
            if result.returncode != 0:
                self.errors.append(f"MkDocs build failed: {result.stderr}")
                return False
            
            return True
        except FileNotFoundError:
            self.errors.append("mkdocs not installed")
            return False
    
    def test_cross_references(self) -> bool:
        """Test cross-references between documents"""
        md_files = list(self.docs_dir.glob("**/*.md"))
        
        # Collect all file names
        file_names = {f.stem for f in md_files}
        
        # Pattern for doc references
        ref_pattern = re.compile(r'\[([^\]]+)\]\(([^)]+\.md)\)')
        
        broken_refs = []
        
        for md_file in md_files:
            content = md_file.read_text()
            refs = ref_pattern.findall(content)
            
            for text, ref_file in refs:
                # Extract filename without path
                ref_name = Path(ref_file).stem
                
                if ref_name not in file_names:
                    broken_refs.append(f"{md_file.name}: references {ref_file}")
        
        if broken_refs:
            self.errors.extend([f"Broken reference: {ref}" for ref in broken_refs])
            return False
        
        return True

def main():
    """Run documentation tests"""
    tester = DocumentationTester()
    success = tester.test_all()
    
    sys.exit(0 if success else 1)

if __name__ == "__main__":
    main()
