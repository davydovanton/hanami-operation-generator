require "dry/cli"
require 'dry/cli/utils/files'
require 'hanami/cli/commands'
require 'hanami/cli/commands/command'

module Hanami
  module Operation
    module Generator
      class CLI < Hanami::CLI::Commands::Command

        desc "Print input"

        argument :domain_name, desc: "Domain for a new operation"
        argument :operation_name, desc: "Name of operation"

        example [
          "accounts create # Will generate Account::Operations::Create operation and spec file for the operation"
        ]

        def call(domain_name:, operation_name:, **)
          context = Hanami::CLI::Commands::Context.new(domain: domain_name, operation: operation_name)

          generate_operation_file(context, domain_name, operation_name)
          generate_spec_file(context, domain_name, operation_name)
        end

      private

        def generate_operation_file(context, domain_name, operation_name)
          source = template_path("operation")
          destination = "#{Hanami.root}/lib/#{domain_name}/operations/#{operation_name}.rb"

          write_file(destination, source, context)
        end

        def generate_spec_file(context, domain_name, operation_name)
          source = template_path("operation_spec")
          destination = "#{Hanami.root}/spec/#{domain_name}/operations/#{operation_name}_spec.rb"
        
          write_file(destination, source, context)
        end

        def template_path(template)
          File.expand_path(File.dirname(__FILE__) +  "/cli/#{template}.erb")
        end

        def write_file(destination, source, context)
          Dry::CLI::Utils::Files.write(
            destination,
            render(source, context)
          )
          say(:create, destination)
        end
      end
    end
  end
end

Hanami::CLI.register "generate", aliases: ["g"] do |prefix|
  prefix.register "operation", Hanami::Operation::Generator::CLI
end
