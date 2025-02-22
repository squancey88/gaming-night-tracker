module Precedence
  def self.map
    {
      1 => "primary",
      2 => "secondary",
      3 => "tertiary",
      4 => "quaternary",
      5 => "quinary",
      6 => "senary",
      7 => "septenary",
      8 => "octonary",
      9 => "nonary",
      10 => "denary"
    }
  end

  def self.label(number)
    map[number] || "unknown"
  end
end
