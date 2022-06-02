# frozen_string_literal: true

RSpec.describe Yousign::Procedure do
  let(:procedure) do
    Yousign::Procedure.new(
      name: "My first procedure",
      description: "Awesome! Here is the description of my first procedure",
      members: [
        {
          firstname: "John",
          lastname: "Doe",
          email: "john.doe@yousign.fr",
          phone: "+33612345678",
          file_objects: [
            {
              file: "/files/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
              page: 2,
              position: "230,499,464,589",
              mention: "Read and approved",
              mention2: "Signed by John Doe"
            }
          ]
        }
      ]
    )
  end

  let(:mocked_api_request) { class_double(Yousign::APIRequest).as_stubbed_const }

  let(:api_response) do
    {
      id: "/procedures/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
      name: "My first procedure",
      description: "Awesome! Here is the description of my first procedure",
      created_at: "2018-12-01T11:49:11+01:00",
      updated_at: "2018-12-01T11:49:11+01:00",
      finished_at: nil,
      expires_at: nil,
      status: "active",
      creator: nil,
      creator_first_name: nil,
      creator_last_name: nil,
      workspace: "/workspaces/XXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
      template: false,
      ordered: false,
      parent: nil,
      metadata: [],
      config: [],
      members: [
        {
          id: "/members/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
          user: nil,
          type: "signer",
          firstname: "John",
          lastname: "Doe",
          email: "john.doe@yousign.fr",
          phone: "+33612345678",
          position: 1,
          created_at: "2018-12-01T11:49:11+01:00",
          updated_at: "2018-12-01T11:49:11+01:00",
          finished_at: nil,
          status: "pending",
          file_objects: [
            {
              id: "/file_objects/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
              file: {
                id: "/files/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
                name: "The best name for my file.pdf",
                type: "signable",
                content_type: "application/pdf",
                description: nil,
                created_at: "2018-12-01T11:36:20+01:00",
                updated_at: "2018-12-01T11:49:11+01:00",
                sha256: "bb57ae2b2ca6ad0133a699350d1a6f6c8cdfde3cf872cf526585d306e4675cc2",
                metadata: [],
                workspace: "/workspaces/XXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
                creator: nil,
                protected: false,
                position: 0,
                parent: nil
              },
              page: 2,
              position: "230,499,464,589",
              field_name: nil,
              mention: "Read and approved",
              mention2: "Signed by John Doe",
              created_at: "2018-12-01T11:49:11+01:00",
              updated_at: "2018-12-01T11:49:11+01:00",
              parent: nil,
              reason: "Signed by Yousign"
            }
          ],
          comment: nil,
          notifications_email: [],
          operation_level: "custom",
          operation_custom_modes: [
            "sms"
          ],
          operation_mode_sms_config: nil,
          parent: nil
        }
      ],
      "subscribers": [],
      "files": [
        {
          id: "/files/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
          name: "The best name for my file.pdf",
          type: "signable",
          content_type: "application/pdf",
          description: nil,
          created_at: "2018-12-01T11:36:20+01:00",
          updated_at: "2018-12-01T11:49:11+01:00",
          sha256: "bb57ae2b2ca6ad0133a699350d1a6f6c8cdfde3cf872cf526585d306e4675cc2",
          metadata: [],
          workspace: "/workspaces/XXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX",
          creator: nil,
          protected: false,
          position: 0,
          parent: nil
        }
      ],
      related_files_enable: false,
      archive: false,
      archive_metadata: [],
      fields: [],
      permissions: []
    }
  end

  before do
    allow(mocked_api_request).to receive(:post).and_return(api_response)
  end

  describe "#create!" do
    it "returns a #{described_class} instance" do
      expect(procedure.create!.class).to eq(described_class)
    end

    it "sets an id" do
      procedure.create!
      expect(procedure.id).to eq("/procedures/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX")
    end
  end
end
