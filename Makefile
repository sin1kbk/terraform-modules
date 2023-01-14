.PHONY: *.apply fmt run-tflint

run-tflint:
	reflex -r '\.tf$$' ./tflint-check.sh
