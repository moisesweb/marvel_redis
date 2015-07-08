describe User do
  context 'find users' do
    it 'returns an user by name' do
      tony = User.find('Tony Stark')
      expect(tony.name).to eq('Tony Stark')
    end

    it 'retuns nil when no match' do
      expect(User.find('Antares')).to be_nil
    end
  end

  context 'user propierties' do
    subject { User.new('Chavo Del Ocho') }
    it 'returns name of user' do
      expect(subject.name).to eq('Chavo Del Ocho')
    end

    it 'returns user image base on name' do
      expect(subject.image).to eq('chavo_del_ocho.jpg')
    end

    it 'returns image name admin dash symbol' do
      expect(User.new('seven-Of-nine').image).to eq('seven-of-nine.jpg')
    end
  end
end
