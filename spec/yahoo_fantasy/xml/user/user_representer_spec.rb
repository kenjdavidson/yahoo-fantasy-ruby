# frozen_string_literal: true

require 'representable'
require 'representable/debug'

RSpec.describe 'TransactionRepresenter' do
  context '/user;out=profile' do
    load_fantasy_content "#{__dir__}/user/user_profile.xml"

    subject { fantasy_content.users[0] }

    it 'should parse meta' do
      expect(subject.guid).to eq('HJXEGSOPDMQLLZFJIQ2BCZA3Z4')
    end

    it 'should parse profile' do
      expect(subject.profile).not_to eq(nil)
      expect(subject.profile.display_name).to eq('Kenneth')
      expect(subject.profile.fantasy_profile_url).to eq('https://profiles.sports.yahoo.com/user/HJXEGSOPDMQLLZFJIQ2BCZA3Z4')
      expect(subject.profile.image_url).to eq('https://s.yimg.com/ag/images/bb794a81-8eb6-4614-b0e4-2399e94a9a38_64sq.jpg')
      expect(subject.profile.unique_username).to eq('kenneth-G7BP4')
    end
  end
end
