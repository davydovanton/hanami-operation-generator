# Hanami::Operation::Generator

Simple library wich will generate operation for hanami-dry-system

## Installation

Add this line to your application's Gemfile:

```ruby
group :plugins do
  gem "hanami-operation-generator", github: 'davydovanton/hanami-operation-generator'
end
```

## Usage

Just call `hanami generate operation <domain> <operation_name>` in terminal. This command will generate two files. Example:


```
$ hanami generate operation order show

    create  project_path/lib/orders/operations/show.rb
    create  project_path/spec/orders/operations/show_spec.rb
```

If you open both files you will see this:

```ruby
# in project_path/lib/orders/operations/show.rb

# frozen_string_literal: true

module Orders
  module Operations
    class List < ::Libs::Operation
      include Import[
      ]

      def call()
        Success(true)
      end
    end
  end
end

# ----------------------------------

# in project_path/spec/orders/operations/show_spec.rb

# frozen_string_literal: true

RSpec.describe Orders::Operations::List, type: :operation do
  subject { operation.call }

  let(:operation) do
    described_class.new
  end

  it { expect(subject).to be_success }

  context 'with real dependencies' do
    subject { operation.call }

    let(:operation) { described_class.new }

    it { expect(subject).to be_success }
  end
end
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/davydovanton/hanami-operation-generator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Hanami::Operation::Generator project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/hanami-operation-generator/blob/master/CODE_OF_CONDUCT.md).
