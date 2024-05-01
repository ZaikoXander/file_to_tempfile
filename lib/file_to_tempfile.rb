# frozen_string_literal: true

require_relative "file_to_tempfile/version"

require "tempfile"

# This module provides a method to convert a File object to a Tempfile object.
module FileToTempfile
  def self.convert(file, using_path: false)
    raise ArgumentError, "Expected a File object as the first argument" unless file.is_a? File
    raise ArgumentError, "Expected a boolean as the second argument" unless [true, false].include?(using_path)
    raise IOError, "The file must be open before it can be converted" if file.closed?

    file.rewind if file.eof?

    tempfile = Tempfile.new(using_path ? file.path : "").tap do |t|
      t.write(file.read)
      t.rewind
    end

    file.rewind
    tempfile
  end
end
