#let midpoint(a, b) = {
    return (
        a.at(0) + (0.5 * (b.at(0) - a.at(0))),
        a.at(1) + (0.5 * (b.at(1) - a.at(1))),
    )
}

#let hypot(a, b) = {
  return calc.sqrt(calc.pow(a, 2) + calc.pow(b, 2))
}


#let quadratic(a, b, c) = {
  let discriminant = b*b - 4*a*c
  if discriminant < 0 {
    return ()
  } else if discriminant == 0 {
    let x = -b / (2*a)
    return (x)
  } else {
    let x1 = (-b + calc.sqrt(discriminant)) / (2*a)
    let x2 = (-b - calc.sqrt(discriminant)) / (2*a)
    return (x1, x2)
  }
}



#let double(n) = {
    return n * 2
}


#let triple(n) = {
    return n * 3
}


