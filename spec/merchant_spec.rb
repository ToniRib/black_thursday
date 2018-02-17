require 'spec_helper'
require './lib/merchant'

describe Merchant do
  subject { described_class.new({ id: 1, name: 'Etsy' }) }

  it 'has a name' do
    expect(subject.name).to eq 'Etsy'
  end

  it 'has an id' do
    expect(subject.id).to eq 1
  end
end
