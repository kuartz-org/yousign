# frozen_string_literal: true

RSpec.describe Yousign::Procedure do
  let(:file_objects) do
    [
      Yousign::FileObject.new(
        file_id: "/files/99999-88888",
        page: 3,
        position: "230,499,464,589",
        mentions: ["Read and approved", "Signed by Alice Doe"]
      )
    ]
  end

  let(:members) do
    [
      Yousign::Member.new(
        first_name: "Alice",
        last_name: "Doe",
        email: "alice.doe@example.com",
        phone: "+33601010101",
        file_objects: file_objects
      )
    ]
  end

  let(:procedure) do
    Yousign::Procedure.new(
      name: "Procedure test",
      description: "This is a test",
      members: members
    )
  end

  describe "#to_hash" do
    it "return correct hash" do
      correct_hash_output = {
        name: "Procedure test",
        description: "This is a test",
        members: [
          {
            first_name: "Alice",
            last_name: "Doe",
            email: "alice.doe@example.com",
            phone: "+33601010101",
            file_objects: [
              {
                file: "/files/99999-88888",
                page: 3,
                position: "230,499,464,589",
                mention: "Read and approved",
                mention2: "Signed by Alice Doe"
              }
            ]
          }
        ]
      }

      expect(procedure.to_hash).to eq(correct_hash_output)
    end
  end
end
