module Guard
  class Jasmine

    # The inspector verifies if the changed paths are valid
    # for Guard::Jasmine. Please note that request to {.clean}
    # paths keeps the current valid files cached until {.clear} is
    # called.
    #
    module Inspector
      class << self

        # Clean the changed paths and return only valid
        # Jasmine specs in either JavaScript or CoffeeScript.
        #
        # @param [Array<String>] paths the changed paths
        # @return [Array<String>] the valid spec files
        #
        def clean(paths)
          paths.uniq!
          paths.compact!

          if paths.include?('spec/javascripts')
            paths = ['spec/javascripts']
          else
            paths = paths.select { |p| jasmine_spec?(p) }
          end

          paths
        end

        # Clears the list of Jasmine specs in this project.
        #
        def clear
          @jasmine_specs = nil
        end

        private

        # Tests if the file is valid.
        #
        # @param [String] file the file
        # @return [Boolean] when the file valid
        #
        def jasmine_spec?(path)
          jasmine_specs.include?(path)
        end

        # Scans the project and keeps a list of all
        # JavaScript and CoffeeScript files in the `spec`
        # directory.
        #
        # @see .clear
        # @return [Array<String>] the valid files
        #
        def jasmine_specs
          @jasmine_specs ||= Dir.glob('spec/**/*_spec.{js,coffee,js.coffee}')
        end

      end
    end
  end
end
