SRCDIR = $(realpath .)
CONFIG_SRC = "$(SRCDIR)/karabiner.edn"
CONFIG_DST = "$(HOME)/.config/karabiner.edn"
OUTPUT = "$(HOME)/.config/karabiner/karabiner.json"

$(OUTPUT): $(CONFIG_DST)
	goku

$(CONFIG_DST):
	cp $(CONFIG_SRC) $(CONFIG_DST)
