
all: test clean

test: test_deps vagrant_up

watch: test_deps
	while sleep 1; do \
		find defaults/ handlers/ meta/ tasks/ templates/ test/integration/default/default.yml \
		| entr make vagrant_up; \
	done

integration_test: integration_test_deps
	./bin/kitchen test

test_deps:
	@echo 'No deps'

integration_test_deps:
	bundler install

vagrant_up:
	vagrant up --no-provision
	vagrant provision

vagrant_ssh:
	vagrant up || exit 1; \
	vagrant ssh

clean:
	vagrant destroy
