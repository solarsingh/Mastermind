arr_originial = ["blue", "red", "green", "green"]
arr2 = ["blue", "red", "red", "green"]
j = 0
arr_originial.each do |elm|
    i = 0
    arr2.each do |elm2|
        if elm == elm2
            arr2[i] = "match" 
            next
        end
        i+=1
    end
    puts arr2.join(", ")
end

arr2.each do |elm|
    if elm == "match"
        j+=1
    end
end

puts j