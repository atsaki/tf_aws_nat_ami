.PHONY: all

all: variables.tf.json

variables.tf.json:
	bundle exec ./getvariables.rb > $@

clean:
	git checkout -- variables.tf.json
