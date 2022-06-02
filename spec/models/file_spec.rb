# frozen_string_literal: true

RSpec.describe Yousign::File do
  let(:mocked_api_request) { class_double(Yousign::APIRequest).as_stubbed_const }
  let(:api_response) do
    {
      id: "/files/999999999-777777",
      name: "test.pdf",
      type: "signable",
      content_type: "application/pdf",
      description: nil,
      created_at: "2022-06-01T20:43:57+02:00",
      updated_at: "2022-06-01T20:43:59+02:00",
      sha256: "82bf0a7ee51e278a1e282ae832df6be96bb1bfaa9286eddc726f44b3b2006731",
      metadata: [],
      workspace: "/workspaces/999999-888888",
      creator: nil,
      file_objects: [],
      protected: false,
      position: 0,
      parent: nil,
      fields_compatible: true,
      company: "/companies/999999-888888"
    }
  end

  before do
    allow(mocked_api_request).to receive(:post).and_return(api_response)
  end

  describe ".upload" do
    it "returns a #{described_class} instance" do
      response = described_class.upload(filename: "test.pdf", file: File.new("spec/fixtures/hello.pdf"))
      expect(response.class).to eq(described_class)
    end

    it "sets an id" do
      file = described_class.upload(filename: "test.pdf", file: File.new("spec/fixtures/hello.pdf"))
      expect(file.id).to eq("/files/999999999-777777")
    end
  end

  describe "#created_at" do
    it "returns an instance of time" do
      file = described_class.upload(filename: "test.pdf", file: File.new("spec/fixtures/hello.pdf"))
      expect(file.created_at.class).to eq(Time)
    end

    it "returns the correct value" do
      file = described_class.upload(filename: "test.pdf", file: File.new("spec/fixtures/hello.pdf"))
      expect(file.created_at).to eq(Time.parse("2022-06-01T20:43:57+02:00"))
    end
  end

  describe "#updated_at" do
    it "returns an instance of time" do
      file = described_class.upload(filename: "test.pdf", file: File.new("spec/fixtures/hello.pdf"))
      expect(file.updated_at.class).to eq(Time)
    end

    it "returns the correct value" do
      file = described_class.upload(filename: "test.pdf", file: File.new("spec/fixtures/hello.pdf"))
      expect(file.updated_at).to eq(Time.parse("2022-06-01T20:43:59+02:00"))
    end
  end
end
