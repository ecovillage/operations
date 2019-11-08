require 'test_helper'

require 'it/user'

class UserTest < Minitest::Test
  include Operations::IT::LDAP

  def test_it_generates_good_uid
    user = User.new first_name: 'First', last_name: 'Last'
    assert_equal user.uid, 'first.last'

    user = User.new first_name: 'CaPITaL', last_name: 'laSt'
    assert_equal user.uid, 'capital.last'

    user = User.new first_name: ' SpaCious ', last_name: '  na me '
    assert_equal user.uid, 'spacious.name'
  end

  def test_it_asiicfies_uid
    user = User.new first_name: 'Sybürgia', last_name: 'Kübenß'
    assert_equal user.uid, 'sybuergia.kuebenss'
  end

  def test_it_honors_titles
    skip
    #user = User_from "Jürgen von der Lippe"
    # should result in juergen.lippe ?
  end
end

