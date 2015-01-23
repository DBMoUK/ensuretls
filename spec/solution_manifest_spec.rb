require 'spec_helper_acceptance'

# Defines a shared example group for solution manifests.
# Pass a manifest to this shared example group by declaring let(:manifest) { some_manifest }
# in the it_behaves_like "a solution manifest" block in your test.

shared_examples_for "a solution manifest" do
  describe 'on first application' do
    it 'should no errors in stderr' do
      apply_manifest(manifest, :catch_failures => true) do |r|
        expect(r.stderr).to_not match(/has failures: true/) 
      end
    end
  end

  describe 'on second application' do
    # I'm not thrilled about this composite test, but can't figure out
    # how to break it up while passing in a manifest to use with apply_manifest.
    it 'should have empty stderr and zero exit code' do
      apply_manifest(manifest, :catch_failures => true) do |r|
        expect(r.stderr).to eq("")
        expect(r.exit_code).to be_zero
        expect(r.stderr).to_not match(/has failures: true/)
      end
    end
  end
end
