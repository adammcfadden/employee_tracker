class Employee < ActiveRecord::Base
  #creates following methods .all, #save, #delete, #update, #==, .find

  define_singleton_method(:get_by_division_id) do |find_division_id|
    in_division = []
    Employee.all().each() do |employee|
      if(employee.division_id == find_division_id)
        in_division.push(employee)
      end
    end
    return in_division
  end

  define_singleton_method(:get_division_id_inverse) do |find_division_id|
    out_division = []
    Employee.all().each() do |employee|
      if(employee.division_id != find_division_id)
        out_division.push(employee)
      end
    end
    return out_division
  end
  # define_singleton_method(:get_by_division_id_inverse) do |find_division_id|
  #   not_in_division =  Employee.all()
  #   not_in_division.delete_if {|employee| Employee.get_by_division_id(find_division_id).contains(employee)}
  #   return not_in_division
  # end

end
