# Config for pandoc

## Install

Install following softwares:

- [pandoc](https://pandoc.org/)
- [pandoc-crossref](https://github.com/lierdakil/pandoc-crossref)
- [pandoc-easy-templates](https://github.com/ryangrose/easy-pandoc-templates)
- [pandoc-pdf](https://github.com/r4ai/pandoc_pdf)

### Commands

macOS:
```sh
brew install pandoc pandoc-crossref && \
  curl 'https://raw.githubusercontent.com/ryangrose/easy-pandoc-templates/master/copy_templates.sh' | bash && \
  pip install pandoc-pdf
```

ArchLinux:

```sh
paru -S pandoc-cli pandoc-crossref && \
  curl 'https://raw.githubusercontent.com/ryangrose/easy-pandoc-templates/master/copy_templates.sh' | bash && \
  pip install pandoc-pdf
```
