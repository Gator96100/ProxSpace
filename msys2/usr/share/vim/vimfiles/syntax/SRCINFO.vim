" Vim syntax file
" Language:         Arch Linux package metadata file
" Original Author:  Ioannis Somos <chronobserver@disroot.org>

if exists('b:current_syntax') | finish | endif

let s:cpo_save = &cpoptions
set cpoptions&vim

" Metadata
syn keyword srcinfoSection
            \ pkgbase
            \ pkgname
            \ skipwhite nextgroup=srcinfoSet
syn keyword srcInfoField
            \ pkgver
            \ pkgrel
            \ epoch
            \ pkgdesc
            \ url
            \ install
            \ changelog
            \ arch
            \ groups
            \ license
            \ noextract
            \ options
            \ backup
            \ validpgpkeys
            \ source
            \ source_x86_64
            \ source_i686
            \ source_pentium4
            \ source_ppc
            \ source_aarch64
            \ source_armv7h
            \ depends
            \ depends_x86_64
            \ depends_i686
            \ depends_pentium4
            \ depends_ppc
            \ depends_aarch64
            \ depends_armv7h
            \ checkdepends
            \ checkdepends_x86_64
            \ checkdepends_i686
            \ checkdepends_pentium4
            \ checkdepends_ppc
            \ checkdepends_aarch64
            \ checkdepends_armv7h
            \ makedepends
            \ makedepends_x86_64
            \ makedepends_i686
            \ makedepends_pentium4
            \ makedepends_ppc
            \ makedepends_aarch64
            \ makedepends_armv7h
            \ optdepends
            \ optdepends_x86_64
            \ optdepends_i686
            \ optdepends_pentium4
            \ optdepends_ppc
            \ optdepends_aarch64
            \ optdepends_armv7h
            \ provides
            \ provides_x86_64
            \ provides_i686
            \ provides_pentium4
            \ provides_ppc
            \ provides_aarch64
            \ provides_armv7h
            \ conflicts
            \ conflicts_x86_64
            \ conflicts_i686
            \ conflicts_pentium4
            \ conflicts_ppc
            \ conflicts_aarch64
            \ conflicts_armv7h
            \ replaces
            \ replaces_x86_64
            \ replaces_i686
            \ replaces_pentium4
            \ replaces_ppc
            \ replaces_aarch64
            \ replaces_armv7h
            \ md5sums
            \ md5sums_x86_64
            \ md5sums_i686
            \ md5sums_pentium4
            \ md5sums_ppc
            \ md5sums_aarch64
            \ md5sums_armv7h
            \ sha1sums
            \ sha1sums_x86_64
            \ sha1sums_i686
            \ sha1sums_pentium4
            \ sha1sums_ppc
            \ sha1sums_aarch64
            \ sha1sums_armv7h
            \ sha224sums
            \ sha224sums_x86_64
            \ sha224sums_i686
            \ sha224sums_pentium4
            \ sha224sums_ppc
            \ sha224sums_aarch64
            \ sha224sums_armv7h
            \ sha256sums
            \ sha256sums_x86_64
            \ sha256sums_i686
            \ sha256sums_pentium4
            \ sha256sums_ppc
            \ sha256sums_aarch64
            \ sha256sums_armv7h
            \ sha384sums
            \ sha384sums_x86_64
            \ sha384sums_i686
            \ sha384sums_pentium4
            \ sha384sums_ppc
            \ sha384sums_aarch64
            \ sha384sums_armv7h
            \ sha512sums
            \ sha512sums_x86_64
            \ sha512sums_i686
            \ sha512sums_pentium4
            \ sha512sums_ppc
            \ sha512sums_aarch64
            \ sha512sums_armv7h
            \ b2sums
            \ b2sums_x86_64
            \ b2sums_i686
            \ b2sums_pentium4
            \ b2sums_ppc
            \ b2sums_aarch64
            \ b2sums_armv7h
            \ skipwhite nextgroup=srcinfoSet
syn match srcinfoSet '=' contained nextgroup=srcinfoValue
syn match srcinfoValue /.\+$/ contained

" Highlights
hi def link srcinfoField Identifier
hi def link srcinfoSection Keyword
hi def link srcinfoSet Operator
hi def link srcinfoValue String

let b:current_syntax = 'SRCINFO'

let &cpoptions = s:cpo_save
unlet s:cpo_save
