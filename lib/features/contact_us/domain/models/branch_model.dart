class BranchModel {
  final String name;
  final String city;
  final String address;
  final String workingHours;
  final String phone;
  final bool isFlagship;

  const BranchModel({
    required this.name,
    required this.city,
    required this.address,
    required this.workingHours,
    required this.phone,
    this.isFlagship = false,
  });

  static const List<BranchModel> defaultBranches = [
    BranchModel(
      name: 'Flagship Boutique',
      city: 'Dubai, UAE',
      address: 'Building 7, Dubai Design District (d3)',
      workingHours: 'Mon - Sat: 10:00 AM - 10:00 PM',
      phone: '+971 4 800 3655',
      isFlagship: true,
    ),
    BranchModel(
      name: 'Downtown Atelier',
      city: 'Cairo, Egypt',
      address: 'North 90th Street, 5th Settlement, New Cairo',
      workingHours: 'Daily: 10:00 AM - 11:00 PM',
      phone: '+20 2 3345 6789',
      isFlagship: false,
    ),
    BranchModel(
      name: 'Heritage Showroom',
      city: 'Riyadh, KSA',
      address: 'Al Olaya Main Road, Riyadh',
      workingHours: 'Sat - Thu: 10:00 AM - 10:30 PM',
      phone: '+966 11 456 7890',
      isFlagship: false,
    ),
  ];
}

