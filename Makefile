# Makefile

.PHONY: init pubget format analyze build test clean env create-feature gen-l10n

init: env pubget build

pubget:
	bash scripts/pubget.sh

format:
	bash scripts/format.sh

analyze:
	bash scripts/analyze.sh

build:
	bash scripts/build_runner.sh

test:
	bash scripts/flutter_test.sh

clean:
	bash scripts/clean.sh

env:
	bash scripts/prepare_env.sh

create-feature:
	@bash scripts/create_feature.sh $(cid) $(name)

gen-l10n:
	@bash scripts/gen_l10n.sh
