describe Metrics, redis: true do
  let(:metrics) { Metrics.new }
  context 'counting user logins' do
    it 'track user when login and count it' do
      metrics.count_login('Tony Stark')
      count = metrics.login_count_for('Tony Stark')
      expect(count).to eq(1)
      count = metrics.login_count_for('Tony Stark')
      expect(count).to eq(2)
    end

    it 'returns top five users by number of logins' do
      4.times { metrics.login_count_for('Tony Stark') }
      6.times { metrics.login_count_for('Groot') }
      3.times { metrics.login_count_for('Ultron') }
      1.times { metrics.login_count_for('Hulk') }
      1.times { metrics.login_count_for('Black Widow') }
      10.times { metrics.login_count_for('Thor') }
      2.times { metrics.login_count_for('Spider-Man') }
      8.times { metrics.login_count_for('Daredevil') }

      expected = ['Thor', 'Daredevil', 'Groot', 'Tony Stark', 'Ultron']
      expect(metrics.top_five_login).to eq(expected)
    end
  end

  context 'track users online' do
    it 'retunrs users who are active in the last minute' do
      time_now = Time.now
      metrics.track_online('Tony Stark')
      metrics.track_online('Groot')
      metrics.track_online('Hulk')
      metrics.track_online('Black Widow')

      Timecop.freeze(time_now)
        expected = ['Tony Stark', 'Groot', 'Hulk', 'Black Widow']
        expect(metrics.users_online).to match_array(expected)
      Timecop.travel(time_now + 30.seconds)
        metrics.track_online('Thor')
      Timecop.travel(time_now + 58.seconds)
        expect(metrics.users_online).to match_array(expected + ['Thor'])
        metrics.track_online('Daredevil')
        metrics.track_online('The Fixer')
      Timecop.travel(time_now + 61.seconds)
        expect(metrics.users_online).to match_array(['Thor', 'Daredevil', 'The Fixer'])
      Timecop.travel(time_now + 91.seconds)
        expect(metrics.users_online).to match_array(['Daredevil', 'The Fixer'])
      Timecop.travel(time_now + (61*2).seconds)
        expect(metrics.users_online).to be_empty

    end

  end

end
