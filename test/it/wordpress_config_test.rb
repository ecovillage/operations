require 'test_helper'

require 'it/wordpress_config'

class WordpressConfigTest < Minitest::Test
  include Operations::IT::Wordpress

  def test_it_extracts_config_values_from_sane_file
    wordpress_config_file_content = <<~WPCONFIG
      define('WP_SITEURL', "https://my.my");
      define('WP_HOME', "https://my.my");
      //define('RELOCATE', true);
      
      // ** MySQL settings - You can get this info from your web host ** //
      /** The name of the database for WordPress */
      define('DB_NAME', 'mydbn');
      
      /** MySQL database username */
      define('DB_USER', 'mydbu');
      
      /** MySQL database password */
      define('DB_PASSWORD', 'mydbp');
      
      /** MySQL hostname */
      define('DB_HOST', 'mydbh');
    WPCONFIG

    lines = wordpress_config_file_content.split("\n")

    user = Config.find_value_of 'DB_NAME', lines
    assert_equal 'mydbn', user

    bogus = Config.find_value_of 'BOGUS', lines
    assert_equal nil, bogus
  end
end

