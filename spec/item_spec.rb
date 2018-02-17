require 'spec_helper'
require './lib/item'

describe Item do
  let(:time) { Time.now }

  subject do
    described_class.new(
      name: 'Pencil',
      description: 'You can use it to write things',
      unit_price: BigDecimal.new(10.99, 4),
      created_at: time,
      updated_at: time,
    )
  end

  it 'has a name' do
    expect(subject.name).to eq 'Pencil'
  end

  it 'has a description' do
    expect(subject.description).to eq 'You can use it to write things'
  end

  it 'has a unit_price' do
    expect(subject.unit_price).to eq BigDecimal.new(10.99, 4)
  end

  it 'has a created_at date' do
    expect(subject.created_at).to eq time
  end

  it 'has a updated_at date' do
    expect(subject.updated_at).to eq time
  end
end
