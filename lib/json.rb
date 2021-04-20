# coding: utf-8
require 'json'
require './web.rb'

class JsonTest < WebTest
  def hv_eq?(k, a, depth=0)
    rst = false
    begin
      rst = a.key?(k)
    rescue e
      rst = false
      p e
    ensure
      puts "#{' '*depth}#{k} #{rst ? '' : '!'}"
      rst
    end
  end
  def get
    JSON.parse(super.get)
  end
  def internal_schema_test(actual, expected)
    rst = self.hv_eq?(k, j)
    if actual.kind_of?(Array)
      # rejectで頑張る
      rst && self.internal_schema_test(actual[k], j[k])
    elsif actual.kind_of?(Hash)
      # keysとrejectで頑張る
      rst && actual
    end
  end
  # keyだけテスト
  def schema_test(params, expected_schema, is_additional=false)
    self.reset_uri unless is_additional
    self.set_params(params)
    rst = false
    begin
      self.internal_schema_test(self.get, expected_schema)
    rescue e
      p e
      rst = false
    ensure
      rst
    end
  end
end
