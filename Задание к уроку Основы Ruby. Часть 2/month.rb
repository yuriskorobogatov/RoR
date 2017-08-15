month=
    {
      "Ja"  => 31,
      "Fe"  => 28,
      "Ma"  => 31,
      "Ap"  => 30,
      "May"  => 31,
      "Ju"  => 30,
      "Jul"  => 31,
      "Aug"  => 31,
      "Sep"  => 30,
      "Oct"  => 31,
      "Nov"  => 30,
      "Dec" => 31
    }
month.each {|k, v| puts  k if v == 30}