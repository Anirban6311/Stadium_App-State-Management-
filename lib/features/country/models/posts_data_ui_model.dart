import 'dart:convert';

class CountryDataModel {
  final int gdp;
  final double sexRatio;
  final int surfaceArea;
  final double lifeExpectancyMale;
  final double unemployment;
  final int imports;
  final double homicideRate;
  final Currency currency;
  final String iso2;
  final double employmentServices;
  final double employmentIndustry;
  final double urbanPopulationGrowth;
  final double secondarySchoolEnrollmentFemale;
  final double employmentAgriculture;
  final String capital;
  final double co2Emissions;
  final double forestedArea;
  final int tourists;
  final int exports;
  final double lifeExpectancyFemale;
  final double postSecondaryEnrollmentFemale;
  final double postSecondaryEnrollmentMale;
  final double primarySchoolEnrollmentFemale;
  final int infantMortality;
  final double gdpGrowth;
  final int threatenedSpecies;
  final int population;
  final double urbanPopulation;
  final double secondarySchoolEnrollmentMale;
  final String name;
  final double popGrowth;
  final String region;
  final double popDensity;
  final double internetUsers;
  final double gdpPerCapita;
  final double fertility;
  final double refugees;
  final double primarySchoolEnrollmentMale;

  CountryDataModel({
    required this.gdp,
    required this.sexRatio,
    required this.surfaceArea,
    required this.lifeExpectancyMale,
    required this.unemployment,
    required this.imports,
    required this.homicideRate,
    required this.currency,
    required this.iso2,
    required this.employmentServices,
    required this.employmentIndustry,
    required this.urbanPopulationGrowth,
    required this.secondarySchoolEnrollmentFemale,
    required this.employmentAgriculture,
    required this.capital,
    required this.co2Emissions,
    required this.forestedArea,
    required this.tourists,
    required this.exports,
    required this.lifeExpectancyFemale,
    required this.postSecondaryEnrollmentFemale,
    required this.postSecondaryEnrollmentMale,
    required this.primarySchoolEnrollmentFemale,
    required this.infantMortality,
    required this.gdpGrowth,
    required this.threatenedSpecies,
    required this.population,
    required this.urbanPopulation,
    required this.secondarySchoolEnrollmentMale,
    required this.name,
    required this.popGrowth,
    required this.region,
    required this.popDensity,
    required this.internetUsers,
    required this.gdpPerCapita,
    required this.fertility,
    required this.refugees,
    required this.primarySchoolEnrollmentMale,
  });

  Map<String, dynamic> toMap() {
    return {
      'gdp': gdp,
      'sex_ratio': sexRatio,
      'surface_area': surfaceArea,
      'life_expectancy_male': lifeExpectancyMale,
      'unemployment': unemployment,
      'imports': imports,
      'homicide_rate': homicideRate,
      'currency': currency.toMap(),
      'iso2': iso2,
      'employment_services': employmentServices,
      'employment_industry': employmentIndustry,
      'urban_population_growth': urbanPopulationGrowth,
      'secondary_school_enrollment_female': secondarySchoolEnrollmentFemale,
      'employment_agriculture': employmentAgriculture,
      'capital': capital,
      'co2_emissions': co2Emissions,
      'forested_area': forestedArea,
      'tourists': tourists,
      'exports': exports,
      'life_expectancy_female': lifeExpectancyFemale,
      'post_secondary_enrollment_female': postSecondaryEnrollmentFemale,
      'post_secondary_enrollment_male': postSecondaryEnrollmentMale,
      'primary_school_enrollment_female': primarySchoolEnrollmentFemale,
      'infant_mortality': infantMortality,
      'gdp_growth': gdpGrowth,
      'threatened_species': threatenedSpecies,
      'population': population,
      'urban_population': urbanPopulation,
      'secondary_school_enrollment_male': secondarySchoolEnrollmentMale,
      'name': name,
      'pop_growth': popGrowth,
      'region': region,
      'pop_density': popDensity,
      'internet_users': internetUsers,
      'gdp_per_capita': gdpPerCapita,
      'fertility': fertility,
      'refugees': refugees,
      'primary_school_enrollment_male': primarySchoolEnrollmentMale,
    };
  }

  factory CountryDataModel.fromMap(Map<String, dynamic> map) {
    return CountryDataModel(
      gdp: map['gdp']?.toInt() ?? 0,
      sexRatio: map['sex_ratio']?.toDouble() ?? 0.0,
      surfaceArea: map['surface_area']?.toInt() ?? 0,
      lifeExpectancyMale: map['life_expectancy_male']?.toDouble() ?? 0.0,
      unemployment: map['unemployment']?.toDouble() ?? 0.0,
      imports: map['imports']?.toInt() ?? 0,
      homicideRate: map['homicide_rate']?.toDouble() ?? 0.0,
      currency: Currency.fromMap(map['currency']),
      iso2: map['iso2'] ?? '',
      employmentServices: map['employment_services']?.toDouble() ?? 0.0,
      employmentIndustry: map['employment_industry']?.toDouble() ?? 0.0,
      urbanPopulationGrowth: map['urban_population_growth']?.toDouble() ?? 0.0,
      secondarySchoolEnrollmentFemale:
          map['secondary_school_enrollment_female']?.toDouble() ?? 0.0,
      employmentAgriculture: map['employment_agriculture']?.toDouble() ?? 0.0,
      capital: map['capital'] ?? '',
      co2Emissions: map['co2_emissions']?.toDouble() ?? 0.0,
      forestedArea: map['forested_area']?.toDouble() ?? 0.0,
      tourists: map['tourists']?.toInt() ?? 0,
      exports: map['exports']?.toInt() ?? 0,
      lifeExpectancyFemale: map['life_expectancy_female']?.toDouble() ?? 0.0,
      postSecondaryEnrollmentFemale:
          map['post_secondary_enrollment_female']?.toDouble() ?? 0.0,
      postSecondaryEnrollmentMale:
          map['post_secondary_enrollment_male']?.toDouble() ?? 0.0,
      primarySchoolEnrollmentFemale:
          map['primary_school_enrollment_female']?.toDouble() ?? 0.0,
      infantMortality: map['infant_mortality']?.toInt() ?? 0,
      gdpGrowth: map['gdp_growth']?.toDouble() ?? 0.0,
      threatenedSpecies: map['threatened_species']?.toInt() ?? 0,
      population: map['population']?.toInt() ?? 0,
      urbanPopulation: map['urban_population']?.toDouble() ?? 0.0,
      secondarySchoolEnrollmentMale:
          map['secondary_school_enrollment_male']?.toDouble() ?? 0.0,
      name: map['name'] ?? '',
      popGrowth: map['pop_growth']?.toDouble() ?? 0.0,
      region: map['region'] ?? '',
      popDensity: map['pop_density']?.toDouble() ?? 0.0,
      internetUsers: map['internet_users']?.toDouble() ?? 0.0,
      gdpPerCapita: map['gdp_per_capita']?.toDouble() ?? 0.0,
      fertility: map['fertility']?.toDouble() ?? 0.0,
      refugees: map['refugees']?.toDouble() ?? 0.0,
      primarySchoolEnrollmentMale:
          map['primary_school_enrollment_male']?.toDouble() ?? 0.0,
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryDataModel.fromJson(String source) =>
      CountryDataModel.fromMap(json.decode(source));
}

class Currency {
  final String code;
  final String name;

  Currency({
    required this.code,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
    };
  }

  factory Currency.fromMap(Map<String, dynamic> map) {
    return Currency(
      code: map['code'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
