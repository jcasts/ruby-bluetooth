class Bluetooth::Service::UUID

  attr_accessor :uuid

  def self.from_integer value
    value = Integer value unless Integer === value

    value = if value < 0xFFFF then
              [value].pack 'n'
            elsif value < 0xFFFFFFFF then
              [value].pack 'N'
            else
              raise NotImplementedError, "only UUID16 and UUID32 are supported"
            end

    new value
  end

  def initialize uuid
    @uuid = uuid
  end

  def to_i
    case uuid.length
    when 16 then
      a, b, c, d = uuid.unpack('NNNN')
      (a << 96) + (b << 64) + (c << 32) + d
    when 4 then
      uuid.unpack('N').first
    when 2 then
      uuid.unpack('n').first
    end
  end

  def to_s
    case uuid.length
    when 16 then
      "%04x%04x-%04x-%04x-%04x-%04x%04x%04x" % uuid.unpack('n8')
    when 4 then
      "%08x" % uuid.unpack('N')
    when 2 then
      "%04x" % uuid.unpack('n')
    else
      raise "unknown bluetooth UUID length: #{uuid.length} (#{uuid.inspect})"
    end
  end

  def inspect
    "u:#{self}"
  end

  alias to_uuid_bytes uuid

end

