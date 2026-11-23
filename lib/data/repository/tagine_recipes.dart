import '../models/diet_type.dart';
import '../models/ingredient.dart';
import '../models/localized_text.dart';
import '../models/recipe.dart';
import '../models/recipe_step.dart';
import 'recipe_tags.dart';

typedef _T = LocalizedText;
typedef _Tag = RecipeTags;

const _img = 'https://www.themealdb.com/images/media/meals';

/// Egyptian clay-pot dishes (طواجن), baked slowly in the oven.
/// Merged into the main data pool in `recipes_data.dart`.
const List<Recipe> tagineRecipes = [
  Recipe(
    id: 'tagine-meat-onion',
    name: _T('Meat & Onion Tagine', 'طاجن لحمة بالبصل'),
    description: _T(
      'Tender beef slow-cooked under a thick layer of caramelised onions '
          'until rich and sweet. A Friday-lunch classic.',
      'لحمة طرية متسوية على نار هادية تحت طبقة بصل متكرمل لحد ما تبقى '
          'غنية وطعمها مسكّر. أكلة غدا الجمعة.',
    ),
    imageUrl: '$_img/n1hcou1628770088.jpg',
    tags: [_Tag.egyptian, _Tag.tagine, _Tag.meat, _Tag.oven],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Beef cubes', 'لحمة مكعبات'),
        quantity: _T('1 kg', 'كيلو'),
      ),
      Ingredient(
        name: _T('Onions', 'بصل'),
        quantity: _T('1 kg, sliced', 'كيلو شرايح'),
      ),
      Ingredient(
        name: _T('Ghee', 'سمنة'),
        quantity: _T('2 tbsp', '٢ معلقة كبيرة'),
      ),
      Ingredient(
        name: _T('Cardamom, bay leaf & allspice', 'حبهان وورق لورا وبهارات'),
        quantity: _T('To taste', 'حسب الرغبة'),
      ),
      Ingredient(
        name: _T('Tomato paste', 'صلصة'),
        quantity: _T('1 tbsp', 'معلقة كبيرة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Boil the meat', 'سلق اللحمة'),
        description: _T(
          'Boil the beef with cardamom, bay leaf and a quartered onion until '
              'nearly tender. Keep the broth.',
          'اسلق اللحمة بالحبهان وورق اللورا وبصلة مقطعة لحد ما تقرب تستوي. '
              'احتفظ بالشوربة.',
        ),
        baseDuration: Duration(minutes: 40),
      ),
      RecipeStep(
        title: _T('Caramelise the onions', 'تشويح البصل'),
        description: _T(
          'Cook the sliced onions slowly in ghee until soft and deep golden.',
          'شوّح البصل الشرايح في السمنة على نار هادية لحد ما يدبل ويبقى دهبي '
              'غامق.',
        ),
        baseDuration: Duration(minutes: 20),
      ),
      RecipeStep(
        title: _T('Fill the tagine', 'رص الطاجن'),
        description: _T(
          'Layer meat and onions in the clay pot, add tomato paste and a cup '
              'of broth.',
          'رص اللحمة والبصل في الطاجن، ضيف الصلصة وكوباية من الشوربة.',
        ),
        baseDuration: Duration(minutes: 5),
      ),
      RecipeStep(
        title: _T('Bake', 'التسوية في الفرن'),
        description: _T(
          'Bake covered, then uncover until the top browns and the sauce '
              'thickens.',
          'دخّله الفرن متغطي، وبعدين اكشفه لحد ما الوش يحمر والصوص يتقل.',
        ),
        baseDuration: Duration(minutes: 35),
      ),
    ],
  ),
  Recipe(
    id: 'tagine-okra',
    name: _T('Okra & Meat Tagine', 'طاجن بامية باللحمة'),
    description: _T(
      'Baby okra and beef in a garlicky tomato sauce with coriander taqliya, '
          'baked in a clay pot.',
      'بامية صغيرة ولحمة في صلصة طماطم بالتوم وطشة الكزبرة، متسوية في الطاجن.',
    ),
    imageUrl: '$_img/k07k271782502861.jpg',
    tags: [_Tag.egyptian, _Tag.tagine, _Tag.meat, _Tag.tomato],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Beef cubes', 'لحمة مكعبات'),
        quantity: _T('750 g', '٧٥٠ جرام'),
      ),
      Ingredient(name: _T('Okra', 'بامية'), quantity: _T('500 g', 'نص كيلو')),
      Ingredient(
        name: _T('Tomato sauce', 'صلصة طماطم'),
        quantity: _T('2 cups', '٢ كوباية'),
      ),
      Ingredient(
        name: _T('Garlic & coriander', 'توم وكزبرة'),
        quantity: _T('For the taqliya', 'للطشة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Boil the meat', 'سلق اللحمة'),
        description: _T(
          'Boil the meat with spices until almost tender.',
          'اسلق اللحمة بالبهارات لحد ما تقرب تستوي.',
        ),
        baseDuration: Duration(minutes: 35),
      ),
      RecipeStep(
        title: _T('Sauté the okra', 'تشويح البامية'),
        description: _T(
          'Trim the okra and sauté briefly in oil so it stays firm.',
          'قمّع البامية وشوّحها شوية في الزيت عشان تفضل ماسكة.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Sauce & taqliya', 'الصلصة والطشة'),
        description: _T(
          'Fry garlic and coriander, add tomato sauce and some broth.',
          'حمّر التوم والكزبرة، ضيف الصلصة وشوية شوربة.',
        ),
        baseDuration: Duration(minutes: 7),
      ),
      RecipeStep(
        title: _T('Bake the tagine', 'تسوية الطاجن'),
        description: _T(
          'Combine everything in the tagine and bake until thick.',
          'حط كل حاجة في الطاجن وادخله الفرن لحد ما يتسبك.',
        ),
        baseDuration: Duration(minutes: 30),
      ),
    ],
  ),
  Recipe(
    id: 'tagine-torly',
    name: _T('Torly Tagine with Meat', 'طاجن تورلي باللحمة'),
    description: _T(
      'Mixed vegetables – zucchini, potatoes, carrots, peas and green beans – '
          'baked with beef in tomato sauce.',
      'خضار مشكل: كوسة وبطاطس وجزر وبسلة وفاصوليا، متسوي مع اللحمة في صلصة '
          'الطماطم.',
    ),
    imageUrl: '$_img/vptwyt1511450962.jpg',
    tags: [_Tag.egyptian, _Tag.tagine, _Tag.meat, _Tag.vegetables],
    diet: DietType.meat,
    servings: 5,
    ingredients: [
      Ingredient(
        name: _T('Beef cubes', 'لحمة مكعبات'),
        quantity: _T('750 g', '٧٥٠ جرام'),
      ),
      Ingredient(
        name: _T('Mixed vegetables', 'خضار مشكل'),
        quantity: _T('1 kg', 'كيلو'),
      ),
      Ingredient(name: _T('Onion', 'بصل'), quantity: _T('2', '٢')),
      Ingredient(
        name: _T('Tomato sauce', 'صلصة طماطم'),
        quantity: _T('2 cups', '٢ كوباية'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Boil the meat', 'سلق اللحمة'),
        description: _T(
          'Boil the meat with onion and spices until nearly done.',
          'اسلق اللحمة بالبصل والبهارات لحد ما تقرب تستوي.',
        ),
        baseDuration: Duration(minutes: 35),
      ),
      RecipeStep(
        title: _T('Cut the vegetables', 'تقطيع الخضار'),
        description: _T(
          'Cut all the vegetables into even chunks.',
          'قطّع الخضار كله مكعبات متساوية.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
      RecipeStep(
        title: _T('Layer & bake', 'الرص والتسوية'),
        description: _T(
          'Mix meat, vegetables, sauced broth and spices in the tagine and '
              'bake until the vegetables are tender.',
          'اخلط اللحمة والخضار والشوربة بالصلصة والبهارات في الطاجن وادخله '
              'الفرن لحد ما الخضار يستوي.',
        ),
        baseDuration: Duration(minutes: 45),
      ),
    ],
  ),
  Recipe(
    id: 'tagine-oxtail',
    name: _T('Oxtail & Onion Tagine', 'طاجن عكاوي بالبصل'),
    description: _T(
      'Oxtail cooked until falling off the bone, then baked with onions and '
          'a light tomato sauce.',
      'عكاوي متسوية لحد ما تسيب العضمة، وبعدين في الطاجن مع البصل وصلصة '
          'خفيفة.',
    ),
    imageUrl: '$_img/1520083578.jpg',
    tags: [_Tag.egyptian, _Tag.tagine, _Tag.meat, _Tag.oven],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Oxtail pieces', 'عكاوي'),
        quantity: _T('1.5 kg', 'كيلو ونص'),
      ),
      Ingredient(name: _T('Onions', 'بصل'), quantity: _T('4', '٤')),
      Ingredient(name: _T('Garlic cloves', 'فصوص توم'), quantity: _T('6', '٦')),
      Ingredient(
        name: _T('Tomato paste', 'صلصة'),
        quantity: _T('2 tbsp', '٢ معلقة كبيرة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Clean & boil', 'التنظيف والسلق'),
        description: _T(
          'Blanch the oxtail, rinse, then simmer with spices until very '
              'tender.',
          'اسلق العكاوي سلقة أولى وارمي الميه، وبعدين سوّيها بالبهارات لحد '
              'ما تطرى جدًا.',
        ),
        baseDuration: Duration(minutes: 60),
      ),
      RecipeStep(
        title: _T('Brown the onions', 'تحمير البصل'),
        description: _T(
          'Fry sliced onions and garlic until golden, stir in the tomato '
              'paste.',
          'حمّر البصل الشرايح والتوم، وضيف الصلصة.',
        ),
        baseDuration: Duration(minutes: 15),
      ),
      RecipeStep(
        title: _T('Bake the tagine', 'تسوية الطاجن'),
        description: _T(
          'Arrange oxtail and onions in the tagine with broth and bake.',
          'رص العكاوي والبصل في الطاجن مع شوية شوربة وادخله الفرن.',
        ),
        baseDuration: Duration(minutes: 30),
      ),
    ],
  ),
  Recipe(
    id: 'tagine-peas-carrots',
    name: _T('Peas & Carrots Meat Tagine', 'طاجن بسلة بالجزر واللحمة'),
    description: _T(
      'Sweet peas and carrots with beef in a tomato sauce, a home-cooked '
          'everyday favourite.',
      'بسلة وجزر مع اللحمة في صلصة طماطم، أكلة بيتي يومية الكل بيحبها.',
    ),
    imageUrl: '$_img/sxxpst1468569714.jpg',
    tags: [_Tag.egyptian, _Tag.tagine, _Tag.meat, _Tag.vegetables],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Beef cubes', 'لحمة مكعبات'),
        quantity: _T('500 g', 'نص كيلو'),
      ),
      Ingredient(name: _T('Peas', 'بسلة'), quantity: _T('500 g', 'نص كيلو')),
      Ingredient(name: _T('Carrots', 'جزر'), quantity: _T('3', '٣')),
      Ingredient(
        name: _T('Tomato sauce', 'صلصة طماطم'),
        quantity: _T('2 cups', '٢ كوباية'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Boil the meat', 'سلق اللحمة'),
        description: _T(
          'Boil the meat with spices until nearly tender.',
          'اسلق اللحمة بالبهارات لحد ما تقرب تستوي.',
        ),
        baseDuration: Duration(minutes: 35),
      ),
      RecipeStep(
        title: _T('Sauté vegetables', 'تشويح الخضار'),
        description: _T(
          'Sauté onion, diced carrots and peas, then add the tomato sauce.',
          'شوّح البصل والجزر المكعبات والبسلة، وضيف الصلصة.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Bake the tagine', 'تسوية الطاجن'),
        description: _T(
          'Add meat and broth, pour into the tagine and bake.',
          'ضيف اللحمة والشوربة، صب في الطاجن وادخله الفرن.',
        ),
        baseDuration: Duration(minutes: 30),
      ),
    ],
  ),
  Recipe(
    id: 'tagine-roz-moammar',
    name: _T('Roz Me\'ammar with Meat', 'طاجن رز معمر باللحمة'),
    description: _T(
      'Creamy baked rice with milk, cream and butter, topped with tender '
          'meat. A rich countryside dish.',
      'رز معمر بالفرن باللبن والقشطة والزبدة، وعليه لحمة طرية. أكلة فلاحي '
          'غنية.',
    ),
    imageUrl: '$_img/qt4i0n1763256454.jpg',
    tags: [_Tag.egyptian, _Tag.tagine, _Tag.meat, _Tag.rice],
    diet: DietType.meat,
    servings: 6,
    ingredients: [
      Ingredient(
        name: _T('Egyptian rice', 'رز مصري'),
        quantity: _T('2 cups', '٢ كوباية'),
      ),
      Ingredient(
        name: _T('Boiled meat', 'لحمة مسلوقة'),
        quantity: _T('500 g', 'نص كيلو'),
      ),
      Ingredient(
        name: _T('Milk & broth', 'لبن وشوربة'),
        quantity: _T('2 cups each', '٢ كوباية من كل نوع'),
      ),
      Ingredient(
        name: _T('Cream (eshta) & butter', 'قشطة وزبدة'),
        quantity: _T('1/2 cup each', 'نص كوباية من كل نوع'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Prepare the rice', 'تجهيز الرز'),
        description: _T(
          'Wash the rice and mix with salt, milk, broth and butter.',
          'اغسل الرز واخلطه بالملح واللبن والشوربة والزبدة.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Fill the tagine', 'رص الطاجن'),
        description: _T(
          'Pour into a buttered tagine, add the meat pieces and top with cream.',
          'صب الخلطة في طاجن مدهون زبدة، حط قطع اللحمة ووشّه بالقشطة.',
        ),
        baseDuration: Duration(minutes: 5),
      ),
      RecipeStep(
        title: _T('Bake', 'التسوية'),
        description: _T(
          'Bake covered until the rice absorbs the liquid, then uncover to '
              'brown the top.',
          'دخّله الفرن متغطي لحد ما الرز يشرب، وبعدين اكشفه عشان الوش يحمر.',
        ),
        baseDuration: Duration(minutes: 60),
      ),
    ],
  ),
  Recipe(
    id: 'tagine-chicken-vegetables',
    name: _T('Chicken & Vegetable Tagine', 'طاجن فراخ بالخضار'),
    description: _T(
      'Chicken pieces baked with potatoes, carrots, onion and peppers in a '
          'spiced tomato sauce.',
      'قطع فراخ متسوية في الفرن مع البطاطس والجزر والبصل والفلفل في صلصة '
          'متبلة.',
    ),
    imageUrl: '$_img/d8bfyg1764117503.jpg',
    tags: [_Tag.egyptian, _Tag.tagine, _Tag.chicken, _Tag.vegetables],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Chicken pieces', 'قطع فراخ'),
        quantity: _T('1 kg', 'كيلو'),
      ),
      Ingredient(
        name: _T('Potatoes & carrots', 'بطاطس وجزر'),
        quantity: _T('3 each', '٣ من كل نوع'),
      ),
      Ingredient(
        name: _T('Onion & peppers', 'بصل وفلفل'),
        quantity: _T('2 each', '٢ من كل نوع'),
      ),
      Ingredient(
        name: _T('Tomato sauce', 'صلصة طماطم'),
        quantity: _T('1.5 cups', 'كوباية ونص'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Season the chicken', 'تتبيل الفراخ'),
        description: _T(
          'Season the chicken with garlic, paprika, cumin and lemon.',
          'تبّل الفراخ بالتوم والبابريكا والكمون والليمون.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Prepare the vegetables', 'تجهيز الخضار'),
        description: _T(
          'Cut the vegetables into chunks and toss with oil and spices.',
          'قطّع الخضار قطع كبيرة وقلّبها في الزيت والبهارات.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Bake the tagine', 'تسوية الطاجن'),
        description: _T(
          'Arrange chicken over the vegetables, pour over the sauce and bake.',
          'رص الفراخ فوق الخضار، صب الصلصة وادخله الفرن.',
        ),
        baseDuration: Duration(minutes: 50),
      ),
    ],
  ),
  Recipe(
    id: 'tagine-kofta-potato',
    name: _T('Kofta & Potato Tagine', 'طاجن كفتة بالبطاطس'),
    description: _T(
      'Kofta fingers baked between potato and tomato slices in a peppery '
          'sauce.',
      'صوابع كفتة متسوية بين شرايح البطاطس والطماطم في صلصة بالفلفل.',
    ),
    imageUrl: '$_img/08ez421782683409.jpg',
    tags: [_Tag.egyptian, _Tag.tagine, _Tag.meat, _Tag.potatoes],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Minced beef', 'لحمة مفرومة'),
        quantity: _T('750 g', '٧٥٠ جرام'),
      ),
      Ingredient(name: _T('Potatoes', 'بطاطس'), quantity: _T('4', '٤')),
      Ingredient(name: _T('Tomatoes', 'طماطم'), quantity: _T('3', '٣')),
      Ingredient(name: _T('Green pepper', 'فلفل أخضر'), quantity: _T('2', '٢')),
    ],
    steps: [
      RecipeStep(
        title: _T('Make the kofta', 'عمل الكفتة'),
        description: _T(
          'Mix the meat with onion, parsley and spices and shape into fingers.',
          'اخلط اللحمة بالبصل والبقدونس والبهارات وشكّلها صوابع.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
      RecipeStep(
        title: _T('Slice the vegetables', 'تقطيع الخضار'),
        description: _T(
          'Slice potatoes, tomatoes and peppers into rounds.',
          'قطّع البطاطس والطماطم والفلفل حلقات.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Layer & bake', 'الرص والتسوية'),
        description: _T(
          'Alternate kofta and vegetables in the tagine, add sauce and bake.',
          'رص الكفتة والخضار بالتبادل في الطاجن، ضيف الصلصة وادخله الفرن.',
        ),
        baseDuration: Duration(minutes: 45),
      ),
    ],
  ),
  Recipe(
    id: 'tagine-orzo-meat',
    name: _T('Orzo & Meat Tagine', 'طاجن لسان عصفور باللحمة'),
    description: _T(
      'Toasted orzo baked in rich meat broth with tender beef chunks on top.',
      'لسان عصفور محمر متسوي في شوربة لحمة غنية وعليه قطع لحمة طرية.',
    ),
    imageUrl: '$_img/4kzx4d1779554755.jpg',
    tags: [_Tag.egyptian, _Tag.tagine, _Tag.meat, _Tag.pasta],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Orzo pasta', 'لسان عصفور'),
        quantity: _T('2 cups', '٢ كوباية'),
      ),
      Ingredient(
        name: _T('Beef cubes', 'لحمة مكعبات'),
        quantity: _T('500 g', 'نص كيلو'),
      ),
      Ingredient(
        name: _T('Meat broth', 'شوربة لحمة'),
        quantity: _T('4 cups', '٤ كوبايات'),
      ),
      Ingredient(
        name: _T('Butter', 'زبدة'),
        quantity: _T('2 tbsp', '٢ معلقة كبيرة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Boil the meat', 'سلق اللحمة'),
        description: _T(
          'Boil the meat with spices and keep the broth.',
          'اسلق اللحمة بالبهارات واحتفظ بالشوربة.',
        ),
        baseDuration: Duration(minutes: 40),
      ),
      RecipeStep(
        title: _T('Toast the orzo', 'تحمير لسان العصفور'),
        description: _T(
          'Toast the orzo in butter until golden.',
          'حمّر لسان العصفور في الزبدة لحد ما يبقى دهبي.',
        ),
        baseDuration: Duration(minutes: 6),
      ),
      RecipeStep(
        title: _T('Bake the tagine', 'تسوية الطاجن'),
        description: _T(
          'Put orzo, hot broth and meat in the tagine and bake until the '
              'liquid is absorbed.',
          'حط لسان العصفور والشوربة السخنة واللحمة في الطاجن وادخله الفرن '
              'لحد ما يشرب.',
        ),
        baseDuration: Duration(minutes: 30),
      ),
    ],
  ),
];
