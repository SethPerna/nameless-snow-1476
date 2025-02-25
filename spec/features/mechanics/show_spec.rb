require 'rails_helper'
describe 'mechanic show page' do
  it 'I see their name, years of experience, and the rides they work on' do
    elitch = AmusementPark.create!(name: 'Elitches', admission_cost: 5)
    seth = Mechanic.create!(name: 'Seth', years_experience: 1)
    joe = Mechanic.create!(name: 'Joe', years_experience: 2)
    ride_1 = Ride.create!(name: 'Ride 1', thrill_rating: 3, open: true, amusement_park_id: elitch.id)
    ride_2 = Ride.create!(name: 'Ride 2', thrill_rating: 2, open: true, amusement_park_id: elitch.id)
    ride_3 = Ride.create!(name: 'Ride 3', thrill_rating: 1, open: true, amusement_park_id: elitch.id)
    mech_ride_1 = MechanicRide.create!(mechanic_id: seth.id, ride_id: ride_1.id)
    mech_ride_2 = MechanicRide.create!(mechanic_id: seth.id, ride_id: ride_2.id)
    mech_ride_3 = MechanicRide.create!(mechanic_id: joe.id, ride_id: ride_3.id)
    visit "/mechanics/#{seth.id}"
    expect(page).to have_content("Name: #{seth.name}")
    expect(page).to_not have_content(joe.name)
    expect(page).to have_content("Experience: #{seth.years_experience}")
    expect(page).to have_content("Rides: #{ride_1.name} #{ride_2.name}")
    expect(page).to_not have_content(ride_3.name)
  end

  it 'I only see rides that are open' do
    elitch = AmusementPark.create!(name: 'Elitches', admission_cost: 5)
    seth = Mechanic.create!(name: 'Seth', years_experience: 1)
    joe = Mechanic.create!(name: 'Joe', years_experience: 2)
    ride_1 = Ride.create!(name: 'Ride 1', thrill_rating: 3, open: true, amusement_park_id: elitch.id)
    ride_2 = Ride.create!(name: 'Ride 2', thrill_rating: 2, open: true, amusement_park_id: elitch.id)
    ride_3 = Ride.create!(name: 'Ride 3', thrill_rating: 1, open: false, amusement_park_id: elitch.id)
    mech_ride_1 = MechanicRide.create!(mechanic_id: seth.id, ride_id: ride_1.id)
    mech_ride_2 = MechanicRide.create!(mechanic_id: seth.id, ride_id: ride_2.id)
    mech_ride_3 = MechanicRide.create!(mechanic_id: seth.id, ride_id: ride_3.id)
    visit "/mechanics/#{seth.id}"
    expect(page).to have_content("Rides: #{ride_1.name} #{ride_2.name}")
    expect(page).to_not have_content(ride_3.name)
  end

  it 'the rides are listed by thrill_rating' do
    elitch = AmusementPark.create!(name: 'Elitches', admission_cost: 5)
    seth = Mechanic.create!(name: 'Seth', years_experience: 1)
    joe = Mechanic.create!(name: 'Joe', years_experience: 2)
    ride_1 = Ride.create!(name: 'Ride 1', thrill_rating: 1, open: true, amusement_park_id: elitch.id)
    ride_2 = Ride.create!(name: 'Ride 2', thrill_rating: 2, open: true, amusement_park_id: elitch.id)
    ride_3 = Ride.create!(name: 'Ride 3', thrill_rating: 3, open: true, amusement_park_id: elitch.id)
    mech_ride_1 = MechanicRide.create!(mechanic_id: seth.id, ride_id: ride_1.id)
    mech_ride_2 = MechanicRide.create!(mechanic_id: seth.id, ride_id: ride_2.id)
    mech_ride_3 = MechanicRide.create!(mechanic_id: seth.id, ride_id: ride_3.id)
    visit "/mechanics/#{seth.id}"
    expect(ride_3.name).to appear_before(ride_2.name)
    expect(ride_2.name).to appear_before(ride_1.name)
  end

  it 'I see a form to add a ride' do
    elitch = AmusementPark.create!(name: 'Elitches', admission_cost: 5)
    seth = Mechanic.create!(name: 'Seth', years_experience: 1)
    joe = Mechanic.create!(name: 'Joe', years_experience: 2)
    ride_1 = Ride.create!(name: 'Ride 1', thrill_rating: 1, open: true, amusement_park_id: elitch.id)
    ride_2 = Ride.create!(name: 'Ride 2', thrill_rating: 2, open: true, amusement_park_id: elitch.id)
    ride_3 = Ride.create!(name: 'Ride 3', thrill_rating: 3, open: true, amusement_park_id: elitch.id)
    ride_4 = Ride.create!(name: 'Ride 4', thrill_rating: 3, open: true, amusement_park_id: elitch.id)
    mech_ride_1 = MechanicRide.create!(mechanic_id: seth.id, ride_id: ride_1.id)
    mech_ride_2 = MechanicRide.create!(mechanic_id: seth.id, ride_id: ride_2.id)
    mech_ride_3 = MechanicRide.create!(mechanic_id: seth.id, ride_id: ride_3.id)
    visit "/mechanics/#{seth.id}"
    expect(page).to have_button("Add Ride")
  end

  it 'when I fill in that form I am taken back to the mechanics show page and I see that ride listed' do
    elitch = AmusementPark.create!(name: 'Elitches', admission_cost: 5)
    seth = Mechanic.create!(name: 'Seth', years_experience: 1)
    joe = Mechanic.create!(name: 'Joe', years_experience: 2)
    ride_1 = Ride.create!(name: 'Ride 1', thrill_rating: 1, open: true, amusement_park_id: elitch.id)
    ride_2 = Ride.create!(name: 'Ride 2', thrill_rating: 2, open: true, amusement_park_id: elitch.id)
    ride_3 = Ride.create!(name: 'Ride 3', thrill_rating: 3, open: true, amusement_park_id: elitch.id)
    ride_4 = Ride.create!(name: 'Ride 4', thrill_rating: 3, open: true, amusement_park_id: elitch.id)
    mech_ride_1 = MechanicRide.create!(mechanic_id: seth.id, ride_id: ride_1.id)
    mech_ride_2 = MechanicRide.create!(mechanic_id: seth.id, ride_id: ride_2.id)
    mech_ride_3 = MechanicRide.create!(mechanic_id: seth.id, ride_id: ride_3.id)
    visit "/mechanics/#{seth.id}"
    fill_in('Ride', with: "#{ride_4.id}")
    click_button("Add Ride")
    expect(current_path).to eq("/mechanics/#{seth.id}")
    expect(page).to have_content(ride_4.name)
  end
end
