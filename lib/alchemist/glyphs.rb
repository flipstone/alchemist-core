module Alchemist
  module Glyphs
    def self.strings
      @chars ||= codes.map {|i| [i].pack("U*") }
    end

    def self.codes
      @codes ||= code_blocks.flat_map(&:to_a)
    end

    def self.code_blocks
      @code_blocks ||= [
        0x0021..0x0024,
        0x0026..0x007e,
        0x0100..0x0220,
        0x0222..0x0233,
        0x0250..0x02ad,
        0x0374..0x0375,
        0x037e..0x037e,
        0x0384..0x038a,
        0x038c..0x038c,
        0x038e..0x03a1,
        0x03a3..0x03ce,
        0x03d0..0x03f6,
        0x0400..0x0482,
        0x0488..0x04ac,
        0x04af..0x04ce,
        0x04d0..0x04f5,
        0x04f8..0x04f9,
        0x0500..0x050f,
        0x20a0..0x20b1,
        0x2100..0x213a,
        0x213d..0x214b,
        0x2153..0x2183,
        0x2190..0x21ff,
        0x2200..0x22ff,
        0x2300..0x23ce,
        0x2460..0x24fe,
        0x2500..0x257f,
        0x2580..0x259f,
        0x2600..0x2613,
        0x2616..0x2617,
        0x2619..0x267d,
        0x2680..0x2689,
        0x2701..0x2704,
        0x2706..0x2709,
        0x270c..0x2727,
        0x2729..0x274b,
        0x274d..0x274d,
        0x274f..0x2752,
        0x2756..0x2756,
        0x2758..0x275e,
        0x2761..0x2794,
        0x2798..0x27af,
        0x27b1..0x27bd,
        0x27f0..0x27ff,
        0x2800..0x28ff,
        0x2900..0x297f,
        0x2980..0x29ff,
        0x2a00..0x2aff,
        0x2e80..0x2e99,
        0x2e9b..0x2ef3,
        0x2f00..0x2fd5,
        0x2ff0..0x2ffb,
        0x3001..0x3020,
        0x3030..0x303f,
        0x3041..0x3054,
        0x305b..0x3096,
        0x309d..0x30ff,
        0x3105..0x312c,
        0x3131..0x318e,
        0x3190..0x319f,
        0x31a0..0x31b7,
        0x3200..0x321c,
        0x3220..0x3244,
        0x3251..0x327b,
        0x327f..0x32cb,
        0x32d0..0x32fe,
        0x3300..0x3377,
        0x337b..0x33dd,
        0x33e0..0x33fe,
        0xa000..0xa48c,
        0x4e00..0x9fff,
      ]

    end
  end
end
