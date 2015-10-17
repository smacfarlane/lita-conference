require "spec_helper"

describe Lita::Handlers::Conference, lita_handler: true do
  it { is_expected.to route_command("conferences").to(:conferences) }
  it { is_expected.to route_command("conference foo").to(:conference) }

  context "Default configuration" do
    it 'responds with default message' do
      send_command("conferences")
      expect(replies.last).to eq("No conference numbers available")
    end
  end

  context "With conferences configured" do
    before do
      registry.config.handlers.conference.conferences = {"Test": "test conference", "Other": "other conference" }
    end

    it 'responds with a list of conferences' do
      send_command("conferences")
      expect(replies.last).to eq("Available Conference Numbers: Test, Other")
    end

    it 'respond with error when requesting an invalid conference' do
      send_command("conference foo")
      expect(replies.last).to eq("That conference number isn't available")
    end

    it 'responds with conference information when requsting a valid conference' do
      send_command("conference test")
      expect(replies.last).to eq("test conference")
    end
  end
  # it "responds with list of conference numbers when there are no parameters" do
  #   send_command("conference")
  #   expect(replies.last).to eq("test conference")
  # end
end
