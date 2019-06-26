describe Fastlane do
  describe Fastlane::FastFile do
    describe "Lock keychain Integration" do
      it "works with path and existing keychain" do
        keychain_path = Tempfile.new('foo').path

        result = Fastlane::FastFile.new.parse("lane :test do
          lock_keychain ({
            path: '#{keychain_path}'
          })
        end").runner.execute(:test)

        expect(result.size).to eq(1)
        expect(result[0]).to eq("security lock-keychain #{keychain_path}")
      end
    end
  end
end
