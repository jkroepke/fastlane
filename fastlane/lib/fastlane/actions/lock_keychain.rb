module Fastlane
  module Actions
    class LockKeychainAction < Action
      def self.run(params)
        keychain_path = FastlaneCore::Helper.keychain_path(params[:path])
        commands = []

        escaped_path = keychain_path.shellescape

        # Log the full path, useful for troubleshooting
        UI.message("Locking keychain at path: #{escaped_path}")
        # lock given keychain
        commands << Fastlane::Actions.sh("security lock-keychain #{escaped_path}", log: false)
        commands
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Lock a keychain"
      end

      def self.details
        "Locks the given keychain file."
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :path,
                                       env_name: "FL_UNLOCK_KEYCHAIN_PATH",
                                       description: "Path to the keychain file",
                                       optional: false)
        ]
      end

      def self.authors
        ["jkroepke"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'lock_keychain( # Lock an existing keychain and add it to the keychain search list
            path: "/path/to/KeychainName.keychain"
          )'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
