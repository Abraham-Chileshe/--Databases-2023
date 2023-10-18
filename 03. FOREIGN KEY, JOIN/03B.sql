SELECT Cars.CarNumber, ParkingPlaces.ParkingNumber FROM Cars
JOIN CarsParkings on Cars.ID = CarsParkings.CarID
JOIN ParkingPlaces ON ParkingPlaces.ID = CarsParkings.ParkingID;
