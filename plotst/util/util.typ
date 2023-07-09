
// Calculates step size for an axis
// full_dist: the distance of the axis while drawing (most likely width or height)
// axis: the axis
// returns: the step size
#let calc_step_size(full_dist, axis) = {
  return full_dist / axis.values.len() / axis.step
}

// transforms a data list ((amount, value),..) to a list only containing values
#let transform_data_full(data_count) = {
  
  if not type(data_count.at(0)) == "array" {
    return data_count
  }
  let new_data = ()
  for (amount, value) in data_count {
    for _ in range(amount) {
      new_data.push(value)
    }
  }
  return new_data
}

// transforms a data list (val1, val2, ...) to a list looking like this ((amount, val1),...)
#let transform_data_count(data_full) = {
  if type(data_full.at(0)) == "array" {
    return data_full
  }

  // count class occurances
  let new_data = ()
  for data in data_full {
   let found = false
   for (idx, entry) in new_data.enumerate() {
     if data == entry.at(1) {
       new_data.at(idx).at(0) += 1
       found = true
       break
     }
   }
   if not found {
      new_data.push((1, data)) //?
   }
  }
  return new_data
}

// converts an integer or 2-long array to a width, height dictionary
#let convert_size(size) = {
  if type(size) == "int" { return (width: size, height: size) }
  if size.len() == 2 { return (width: size.at(0), height: size.at(1)) }
}

#let draw_marking(data, markings) = {
  if markings == none { return }
  if markings == "square" {
    markings = square(size: 2pt, fill: black, stroke: none)
  } else if markings == "circle" {
    markings = circle(radius: 1pt, fill: black, stroke: none)
  } else if markings == "cross" {
    markings = {
      place(line(angle: 45deg, length: 1pt))
      place(line(angle: -45deg, length: 1pt))
      place(line(angle: 135deg, length: 1pt))
      place(line(angle: -135deg, length: 1pt))
    }
  }
  style(s => {
    let (width, height) = measure(markings, s)
    place(dx: data.at(0) - width/2, dy: data.at(1) - height/2, markings)
  })
}