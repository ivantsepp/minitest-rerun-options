# minitest-rerun-options

Outputs the command line options to rerun failing tests

## Description

This plugin adds a reporter that outputs command line options for failing tests. As an example:

```
$ ruby test/test_examples/test_with_failures.rb
Run options: --seed 39171

# Running:

.FF..

Finished in 0.001130s, 4424.7788 runs/s, 4424.7788 assertions/s.

  1) Failure:
TestExample#test_another_that_will_fail [test/test_examples/test_with_failures.rb:14]:
Failed assertion, no message given.


  2) Failure:
TestExample#test_that_will_fail [test/test_examples/test_with_failures.rb:10]:
Failed assertion, no message given.

5 runs, 5 assertions, 2 failures, 0 errors, 0 skips

Rerun failed tests options:
--name TestExample#test_another_that_will_fail
--name TestExample#test_that_will_fail
--names TestExample#test_another_that_will_fail,TestExample#test_that_will_fail
```

Then you can rerun a single failure:
`ruby test/test_examples/test_with_failures.rb --name TestExample#test_that_will_fail`

Or all failing tests:
`ruby test/test_examples/test_with_failures.rb --names TestExample#test_another_that_will_fail,TestExample#test_that_will_fail`

If you are using Rake, it will output the environment variable that Rake uses:

```
Rerun failed tests options:
TEST_OPTS="--name TestExample#test_that_will_fail"
TEST_OPTS="--name TestExample#test_another_that_will_fail"
TEST_OPTS="--names TestExample#test_that_will_fail,TestExample#test_another_that_will_fail"
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'minitest-rerun-option'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install minitest-rerun-option

And that's it! This is a Minitest plugin which means that it will be autoloaded.

## Contributing

1. Fork it ( https://github.com/ivantsepp/minitest-rerun-options/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
