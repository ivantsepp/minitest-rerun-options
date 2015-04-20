require 'test_helper'

class TestRerunOptions < Minitest::Test
  def file_to_run(name)
    File.join(File.expand_path('..', __FILE__), 'test_examples', name)
  end

  def test_no_output_if_tests_pass
    test_file = file_to_run('test_without_failures.rb')
    output = `ruby #{test_file}`
    refute_includes output, "Rerun failed tests options:"
  end

  def test_single_run_options_from_ruby
    test_file = file_to_run('test_with_failures.rb')
    output = `ruby #{test_file}`
    assert_includes output, "--name TestExample#test_another_that_will_fail"
    assert_includes output, "--name TestExample#test_that_will_fail"
  end

  def test_multiple_run_option_from_ruby
    test_file = file_to_run('test_with_failures.rb')
    output = `ruby #{test_file}`
    option = /^.*--names.*$/.match(output)[0]
    assert_includes option, "TestExample#test_another_that_will_fail"
    assert_includes option, "TestExample#test_that_will_fail"
  end

  def test_multiple_run_option_hidden_for_one_failure
    test_file = file_to_run('test_with_one_failure.rb')
    output = `ruby #{test_file}`
    refute_includes output, "--names"
  end

  def test_single_run_options_from_rake
    output = nil
    Dir.chdir File.join(File.expand_path('..', __FILE__), 'test_examples') do
      output = `TEST="test_with_failures.rb" bundle exec rake 2>/dev/null`
    end
    assert_includes output, "TEST_OPTS=\"--name TestExample#test_another_that_will_fail\""
    assert_includes output, "TEST_OPTS=\"--name TestExample#test_that_will_fail\""
  end

  def test_multiple_run_option_from_rake
    output = nil
    Dir.chdir File.join(File.expand_path('..', __FILE__), 'test_examples') do
      output = `TEST="test_with_failures.rb" bundle exec rake 2>/dev/null`
    end
    option = /^.*TEST_OPTS=\"--names.*$/.match(output)[0]
    assert_includes option, "TestExample#test_another_that_will_fail"
    assert_includes option, "TestExample#test_that_will_fail"
  end

  def test_names_option_correctly_filters_runs
    test_file = file_to_run('test_with_failures.rb')
    output = `ruby #{test_file} --names TestExample#test_hello_world,TestExample#test_passing`
    assert_includes output, "one"
    assert_includes output, "two"
    refute_includes output, "three"
  end

  def test_single_run_options_from_spec
    test_file = file_to_run('test_with_spec_format.rb')
    output = `ruby #{test_file}`
    assert_includes output, "--name Minitest::nesting one level#test_0001_should still work"
  end

end
