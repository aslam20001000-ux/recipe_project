import '../models/diet_type.dart';
import '../models/ingredient.dart';
import '../models/localized_text.dart';
import '../models/recipe.dart';
import '../models/recipe_step.dart';
import 'recipe_tags.dart';

typedef _T = LocalizedText;
typedef _Tag = RecipeTags;

const _img = 'https://www.themealdb.com/images/media/meals';

/// Meat and chicken dishes, Egyptian favourites first.
/// Merged into the main data pool in `recipes_data.dart`.
const List<Recipe> meatAndChickenRecipes = [
  // ─────────────────────────── Egyptian / Oriental ───────────────────────────
  Recipe(
    id: 'kofta-mashwia',
    name: _T('Grilled Kofta', 'كفتة مشوية'),
    description: _T(
      'Spiced minced beef skewers grilled over high heat, served with tahini, '
          'salad and baladi bread.',
      'كفتة لحمة متبلة على أسياخ ومشوية على نار عالية، بتتقدم مع الطحينة '
          'والسلطة والعيش البلدي.',
    ),
    imageUrl: '$_img/04axct1763793018.jpg',
    tags: [_Tag.egyptian, _Tag.meat, _Tag.grill],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Minced beef', 'لحمة مفرومة'),
        quantity: _T('1 kg', 'كيلو'),
      ),
      Ingredient(name: _T('Grated onion', 'بصل مبشور'), quantity: _T('2', '٢')),
      Ingredient(
        name: _T('Chopped parsley', 'بقدونس مفروم'),
        quantity: _T('1/2 bunch', 'نص حزمة'),
      ),
      Ingredient(
        name: _T('Kofta spices', 'بهارات كفتة'),
        quantity: _T('1 tbsp', 'معلقة كبيرة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Mix the kofta', 'خلط الكفتة'),
        description: _T(
          'Squeeze the grated onion dry, then knead it into the meat with '
              'parsley, salt and spices.',
          'اعصر البصل المبشور من ميته واعجنه مع اللحمة والبقدونس والملح '
              'والبهارات.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Rest & shape', 'الراحة والتشكيل'),
        description: _T(
          'Chill the mix, then shape long fingers around the skewers.',
          'سيب الخلطة في التلاجة شوية، وبعدين شكّلها صوابع طويلة على الأسياخ.',
        ),
        baseDuration: Duration(minutes: 15),
      ),
      RecipeStep(
        title: _T('Grill', 'الشوي'),
        description: _T(
          'Grill on a very hot grill, turning, until browned and cooked through.',
          'اشويها على شواية سخنة جدًا وقلّبها لحد ما تحمر وتستوي.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
    ],
  ),
  Recipe(
    id: 'hawawshi',
    name: _T('Hawawshi', 'حواوشي'),
    description: _T(
      'Baladi bread stuffed with spiced minced meat, onion and chili, baked '
          'until crispy. Cairo street food at its best.',
      'عيش بلدي محشي لحمة مفرومة متبلة ببصل وفلفل حار ومتسوي في الفرن لحد ما '
          'يقرمش. أكلة شارع مصرية أصلية.',
    ),
    imageUrl: '$_img/lgmnff1763789847.jpg',
    tags: [_Tag.egyptian, _Tag.meat, _Tag.bread, _Tag.oven],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Minced beef', 'لحمة مفرومة'),
        quantity: _T('500 g', 'نص كيلو'),
      ),
      Ingredient(
        name: _T('Baladi bread', 'عيش بلدي'),
        quantity: _T('4 loaves', '٤ أرغفة'),
      ),
      Ingredient(
        name: _T('Onion & green pepper', 'بصل وفلفل أخضر'),
        quantity: _T('1 each', 'واحدة من كل نوع'),
      ),
      Ingredient(
        name: _T('Hot chili', 'شطة'),
        quantity: _T('To taste', 'حسب الرغبة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Season the meat', 'تتبيل اللحمة'),
        description: _T(
          'Mix the meat with chopped onion, pepper, chili, salt and spices.',
          'اخلط اللحمة بالبصل والفلفل المفروم والشطة والملح والبهارات.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Stuff the bread', 'حشو العيش'),
        description: _T(
          'Open each loaf and spread a thin, even layer of meat inside.',
          'افتح كل رغيف وافرد جواه طبقة لحمة رفيعة ومتساوية.',
        ),
        baseDuration: Duration(minutes: 7),
      ),
      RecipeStep(
        title: _T('Bake', 'التسوية'),
        description: _T(
          'Brush with oil and bake in a hot oven until the bread is crunchy.',
          'ادهنه بالزيت وادخله فرن سخن لحد ما العيش يقرمش.',
        ),
        baseDuration: Duration(minutes: 20),
      ),
    ],
  ),
  Recipe(
    id: 'macarona-bechamel',
    name: _T('Macarona Béchamel', 'مكرونة بشاميل'),
    description: _T(
      'Egyptian baked pasta layered with spiced minced meat and a thick, '
          'golden béchamel crust.',
      'مكرونة بالفرن بطبقة لحمة مفرومة متبلة ووشّ بشاميل تقيل ودهبي.',
    ),
    imageUrl: '$_img/wtsvxx1511296896.jpg',
    tags: [_Tag.egyptian, _Tag.meat, _Tag.pasta, _Tag.oven],
    diet: DietType.meat,
    servings: 6,
    ingredients: [
      Ingredient(
        name: _T('Penne pasta', 'مكرونة قلم'),
        quantity: _T('500 g', 'نص كيلو'),
      ),
      Ingredient(
        name: _T('Minced beef', 'لحمة مفرومة'),
        quantity: _T('500 g', 'نص كيلو'),
      ),
      Ingredient(name: _T('Milk', 'لبن'), quantity: _T('1 litre', 'لتر')),
      Ingredient(
        name: _T('Butter & flour', 'زبدة ودقيق'),
        quantity: _T('100 g each', '١٠٠ جرام من كل نوع'),
      ),
      Ingredient(name: _T('Onion', 'بصل'), quantity: _T('1', 'واحدة')),
    ],
    steps: [
      RecipeStep(
        title: _T('Cook the meat', 'تسوية اللحمة'),
        description: _T(
          'Brown the minced meat with onion, salt, pepper and a little '
              'tomato paste.',
          'شوّح اللحمة المفرومة مع البصل والملح والفلفل وشوية صلصة.',
        ),
        baseDuration: Duration(minutes: 15),
      ),
      RecipeStep(
        title: _T('Boil the pasta', 'سلق المكرونة'),
        description: _T(
          'Boil the pasta until just under al dente and drain.',
          'اسلق المكرونة لحد قبل ما تستوي خالص وصفّيها.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Make the béchamel', 'عمل البشاميل'),
        description: _T(
          'Melt butter, stir in flour, then whisk in milk until thick. Season '
              'with salt and nutmeg.',
          'دوّب الزبدة، ضيف الدقيق، وبعدين اللبن وانت بتقلّب لحد ما يتقل. '
              'تبّل بملح وجوزة الطيب.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
      RecipeStep(
        title: _T('Layer & bake', 'الرص والتسوية'),
        description: _T(
          'Layer pasta, meat, pasta, then pour over the béchamel and bake until '
              'golden.',
          'رص مكرونة ثم لحمة ثم مكرونة، صب البشاميل على الوش وادخلها الفرن لحد '
              'ما تحمر.',
        ),
        baseDuration: Duration(minutes: 30),
      ),
    ],
  ),
  Recipe(
    id: 'oven-roast-chicken',
    name: _T('Oven Roasted Chicken', 'فراخ في الفرن'),
    description: _T(
      'Whole chicken marinated in garlic, lemon and spices, roasted with '
          'potatoes until golden and juicy.',
      'فرخة متبلة بالتوم والليمون والبهارات، متحمرة في الفرن مع البطاطس لحد '
          'ما تبقى دهبية وطرية.',
    ),
    imageUrl: '$_img/nlxald1764112200.jpg',
    tags: [_Tag.egyptian, _Tag.chicken, _Tag.potatoes, _Tag.oven],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Whole chicken', 'فرخة كاملة'),
        quantity: _T('1', 'واحدة'),
      ),
      Ingredient(name: _T('Potatoes', 'بطاطس'), quantity: _T('4', '٤')),
      Ingredient(name: _T('Garlic cloves', 'فصوص توم'), quantity: _T('6', '٦')),
      Ingredient(name: _T('Lemon', 'ليمون'), quantity: _T('2', '٢')),
      Ingredient(
        name: _T('Paprika & cumin', 'بابريكا وكمون'),
        quantity: _T('1 tbsp each', 'معلقة من كل نوع'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Marinate', 'التتبيل'),
        description: _T(
          'Rub the chicken inside and out with garlic, lemon, oil and spices.',
          'ادعك الفرخة من جوه وبره بالتوم والليمون والزيت والبهارات.',
        ),
        baseDuration: Duration(minutes: 15),
      ),
      RecipeStep(
        title: _T('Prepare the tray', 'تجهيز الصينية'),
        description: _T(
          'Cut the potatoes into wedges, season and arrange around the chicken.',
          'قطّع البطاطس قطع كبيرة، تبّلها ورصّها حوالين الفرخة.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Roast', 'التحمير'),
        description: _T(
          'Roast covered, then uncover and roast until golden, basting often.',
          'سوّيها متغطية، وبعدين اكشفها وحمّرها وانت بتسقيها من الصوص.',
        ),
        baseDuration: Duration(minutes: 60),
      ),
    ],
  ),
  Recipe(
    id: 'kofta-dawood-basha',
    name: _T('Dawood Basha Meatballs', 'كفتة داود باشا'),
    description: _T(
      'Tender meatballs simmered in a rich tomato sauce, served with '
          'vermicelli rice.',
      'كور كفتة طرية متسبكة في صلصة طماطم غنية، بتتقدم مع الرز بالشعرية.',
    ),
    imageUrl: '$_img/8rfd4q1764112993.jpg',
    tags: [_Tag.egyptian, _Tag.meat, _Tag.tomato, _Tag.sauce],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Minced beef', 'لحمة مفرومة'),
        quantity: _T('750 g', '٧٥٠ جرام'),
      ),
      Ingredient(
        name: _T('Tomato sauce', 'صلصة طماطم'),
        quantity: _T('3 cups', '٣ كوبايات'),
      ),
      Ingredient(name: _T('Onion', 'بصل'), quantity: _T('2', '٢')),
      Ingredient(
        name: _T('Bell pepper', 'فلفل رومي'),
        quantity: _T('1', 'واحدة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Shape the meatballs', 'تشكيل الكور'),
        description: _T(
          'Season the meat and roll into small balls.',
          'تبّل اللحمة وشكّلها كور صغيرة.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
      RecipeStep(
        title: _T('Brown', 'التحمير'),
        description: _T(
          'Brown the meatballs in a little oil on all sides.',
          'حمّر الكور في شوية زيت من كل النواحي.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Simmer in sauce', 'التسبيك في الصلصة'),
        description: _T(
          'Sauté onion and pepper, add the tomato sauce and meatballs and '
              'simmer until thick.',
          'شوّح البصل والفلفل، ضيف الصلصة والكفتة وسيبها تتسبك لحد ما تتقل.',
        ),
        baseDuration: Duration(minutes: 25),
      ),
    ],
  ),
  Recipe(
    id: 'meat-potato-tagine',
    name: _T('Meat & Potato Tagine', 'طاجن لحمة بالبطاطس'),
    description: _T(
      'Slow-cooked beef chunks with potatoes, onion and tomato, baked in a '
          'clay pot.',
      'قطع لحمة متسوية على نار هادية مع البطاطس والبصل والطماطم في طاجن فخار.',
    ),
    imageUrl: '$_img/yuwtuu1511295751.jpg',
    tags: [_Tag.egyptian, _Tag.tagine, _Tag.meat, _Tag.potatoes],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Beef cubes', 'لحمة مكعبات'),
        quantity: _T('750 g', '٧٥٠ جرام'),
      ),
      Ingredient(name: _T('Potatoes', 'بطاطس'), quantity: _T('4', '٤')),
      Ingredient(name: _T('Onion', 'بصل'), quantity: _T('2', '٢')),
      Ingredient(name: _T('Tomatoes', 'طماطم'), quantity: _T('3', '٣')),
    ],
    steps: [
      RecipeStep(
        title: _T('Sear the meat', 'تشويح اللحمة'),
        description: _T(
          'Sear the beef with onion and spices until browned.',
          'شوّح اللحمة مع البصل والبهارات لحد ما تحمر.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
      RecipeStep(
        title: _T('Simmer', 'التسوية'),
        description: _T(
          'Add water and simmer until the meat is almost tender.',
          'ضيف مية وسيبها على نار هادية لحد ما اللحمة تقرب تستوي.',
        ),
        baseDuration: Duration(minutes: 40),
      ),
      RecipeStep(
        title: _T('Bake in the tagine', 'الطاجن في الفرن'),
        description: _T(
          'Layer meat, potatoes and tomato slices in the tagine and bake.',
          'رص اللحمة والبطاطس وشرايح الطماطم في الطاجن وادخله الفرن.',
        ),
        baseDuration: Duration(minutes: 30),
      ),
    ],
  ),
  Recipe(
    id: 'alexandrian-sausage',
    name: _T('Alexandrian Sausage', 'سجق إسكندراني'),
    description: _T(
      'Spicy beef sausages fried with peppers, tomato and garlic, '
          'Alexandria style.',
      'سجق حار متشوح مع الفلفل والطماطم والتوم على الطريقة الإسكندراني.',
    ),
    imageUrl: '$_img/vc08jn1628769553.jpg',
    tags: [_Tag.egyptian, _Tag.meat, _Tag.spicy],
    diet: DietType.meat,
    servings: 3,
    ingredients: [
      Ingredient(
        name: _T('Beef sausage', 'سجق بلدي'),
        quantity: _T('500 g', 'نص كيلو'),
      ),
      Ingredient(
        name: _T('Green & red peppers', 'فلفل أخضر وأحمر'),
        quantity: _T('2', '٢'),
      ),
      Ingredient(name: _T('Tomatoes', 'طماطم'), quantity: _T('2', '٢')),
      Ingredient(name: _T('Garlic cloves', 'فصوص توم'), quantity: _T('4', '٤')),
    ],
    steps: [
      RecipeStep(
        title: _T('Fry the sausage', 'تحمير السجق'),
        description: _T(
          'Cut the sausage into pieces and fry until browned.',
          'قطّع السجق حتت وحمّره.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Add the vegetables', 'إضافة الخضار'),
        description: _T(
          'Add garlic, peppers and tomatoes with cumin and chili and cook '
              'until soft.',
          'ضيف التوم والفلفل والطماطم مع الكمون والشطة وسيبهم لحد ما يطروا.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
    ],
  ),
  Recipe(
    id: 'chicken-pane',
    name: _T('Chicken Pané', 'فراخ بانيه'),
    description: _T(
      'Thin chicken breast fillets coated in breadcrumbs and fried until '
          'golden and crunchy.',
      'شرايح صدور فراخ رفيعة متغطية بالبقسماط ومقلية لحد ما تبقى دهبية '
          'ومقرمشة.',
    ),
    imageUrl: '$_img/40r49m1763197022.jpg',
    tags: [_Tag.egyptian, _Tag.chicken, _Tag.fried],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Chicken breasts', 'صدور فراخ'),
        quantity: _T('3', '٣'),
      ),
      Ingredient(name: _T('Eggs', 'بيض'), quantity: _T('2', '٢')),
      Ingredient(
        name: _T('Breadcrumbs', 'بقسماط'),
        quantity: _T('2 cups', '٢ كوباية'),
      ),
      Ingredient(
        name: _T('Garlic & lemon', 'توم وليمون'),
        quantity: _T('For marinating', 'للتتبيل'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Slice & marinate', 'التقطيع والتتبيل'),
        description: _T(
          'Slice the breasts into thin fillets, pound them and marinate with '
              'garlic, lemon and spices.',
          'قطّع الصدور شرايح رفيعة، اخبطها وتبّلها بالتوم والليمون والبهارات.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
      RecipeStep(
        title: _T('Coat', 'التغطية'),
        description: _T(
          'Dip each fillet in beaten egg, then press into breadcrumbs.',
          'غمّس كل شريحة في البيض المخفوق وبعدين في البقسماط.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Fry', 'القلي'),
        description: _T(
          'Fry in hot oil a few minutes per side until golden.',
          'اقليها في زيت سخن كام دقيقة كل ناحية لحد ما تحمر.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
    ],
  ),
  Recipe(
    id: 'chicken-noodle-soup',
    name: _T('Chicken Orzo Soup', 'شوربة فراخ بلسان العصفور'),
    description: _T(
      'Comforting chicken broth with orzo pasta, a warm Egyptian winter '
          'classic.',
      'شوربة فراخ دافية بلسان العصفور، الأكلة المصرية المفضلة في الشتا.',
    ),
    imageUrl: '$_img/lx1kkj1593349302.jpg',
    tags: [_Tag.egyptian, _Tag.chicken, _Tag.soup],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Chicken pieces', 'قطع فراخ'),
        quantity: _T('1 kg', 'كيلو'),
      ),
      Ingredient(
        name: _T('Orzo pasta', 'لسان عصفور'),
        quantity: _T('1 cup', 'كوباية'),
      ),
      Ingredient(
        name: _T('Onion, carrot & celery', 'بصل وجزر وكرفس'),
        quantity: _T('1 each', 'واحدة من كل نوع'),
      ),
      Ingredient(
        name: _T('Cardamom & bay leaf', 'حبهان وورق لورا'),
        quantity: _T('A few', 'شوية'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Make the broth', 'عمل الشوربة'),
        description: _T(
          'Boil the chicken with vegetables and spices, skimming the foam.',
          'اسلق الفراخ مع الخضار والبهارات وشيل الريم.',
        ),
        baseDuration: Duration(minutes: 35),
      ),
      RecipeStep(
        title: _T('Toast the orzo', 'تحمير لسان العصفور'),
        description: _T(
          'Toast the orzo in a little butter until lightly golden.',
          'حمّر لسان العصفور في شوية زبدة لحد ما ياخد لون خفيف.',
        ),
        baseDuration: Duration(minutes: 5),
      ),
      RecipeStep(
        title: _T('Cook together', 'التسوية'),
        description: _T(
          'Add the strained broth to the orzo and simmer until tender.',
          'ضيف الشوربة المصفاة على لسان العصفور وسيبها لحد ما يستوي.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
    ],
  ),
  Recipe(
    id: 'chicken-wings-lemon',
    name: _T('Lemon & Cumin Wings', 'جوانح فراخ بالليمون والكمون'),
    description: _T(
      'Crispy oven-baked chicken wings with cumin, lemon and garlic.',
      'جوانح فراخ مقرمشة في الفرن بالكمون والليمون والتوم.',
    ),
    imageUrl: '$_img/4hzyvq1763792564.jpg',
    tags: [_Tag.chicken, _Tag.oven],
    diet: DietType.meat,
    servings: 3,
    ingredients: [
      Ingredient(
        name: _T('Chicken wings', 'جوانح فراخ'),
        quantity: _T('1 kg', 'كيلو'),
      ),
      Ingredient(
        name: _T('Cumin', 'كمون'),
        quantity: _T('2 tsp', '٢ معلقة صغيرة'),
      ),
      Ingredient(name: _T('Lemon', 'ليمون'), quantity: _T('2', '٢')),
      Ingredient(name: _T('Garlic cloves', 'فصوص توم'), quantity: _T('4', '٤')),
    ],
    steps: [
      RecipeStep(
        title: _T('Marinate', 'التتبيل'),
        description: _T(
          'Toss the wings with cumin, garlic, lemon zest, salt and oil.',
          'قلّب الجوانح مع الكمون والتوم وقشر الليمون والملح والزيت.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Bake', 'التسوية'),
        description: _T(
          'Bake on a rack in a hot oven, turning once, until crispy.',
          'سوّيها على شبكة في فرن سخن واقلبها مرة لحد ما تقرمش.',
        ),
        baseDuration: Duration(minutes: 35),
      ),
      RecipeStep(
        title: _T('Finish', 'اللمسة الأخيرة'),
        description: _T(
          'Squeeze over lemon juice and serve hot.',
          'اعصر عليها ليمون وقدّمها سخنة.',
        ),
        baseDuration: Duration(minutes: 2),
      ),
    ],
  ),
  Recipe(
    id: 'chicken-mandi',
    name: _T('Chicken Mandi', 'مندي فراخ'),
    description: _T(
      'Fragrant spiced rice cooked under roasted chicken, a Yemeni favourite '
          'loved across the Arab world.',
      'رز مبهر ريحته حلوة متسوي تحت الفراخ المحمرة، أكلة يمني بيحبها '
          'الوطن العربي كله.',
    ),
    imageUrl: '$_img/er4d081765186828.jpg',
    tags: [_Tag.chicken, _Tag.rice, _Tag.oven],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Chicken halves', 'أنصاص فراخ'),
        quantity: _T('2', '٢'),
      ),
      Ingredient(
        name: _T('Basmati rice', 'رز بسمتي'),
        quantity: _T('3 cups', '٣ كوبايات'),
      ),
      Ingredient(
        name: _T('Mandi spices', 'بهارات مندي'),
        quantity: _T('2 tbsp', '٢ معلقة كبيرة'),
      ),
      Ingredient(name: _T('Onion', 'بصل'), quantity: _T('1', 'واحدة')),
    ],
    steps: [
      RecipeStep(
        title: _T('Season the chicken', 'تتبيل الفراخ'),
        description: _T(
          'Rub the chicken with mandi spices, oil and salt.',
          'ادهن الفراخ ببهارات المندي والزيت والملح.',
        ),
        baseDuration: Duration(minutes: 10),
      ),
      RecipeStep(
        title: _T('Boil the chicken', 'سلق الفراخ'),
        description: _T(
          'Simmer the chicken briefly in water and keep the broth.',
          'اسلق الفراخ شوية في مية واحتفظ بالشوربة.',
        ),
        baseDuration: Duration(minutes: 20),
      ),
      RecipeStep(
        title: _T('Cook rice & roast', 'الرز والتحمير'),
        description: _T(
          'Cook the rice in the broth with spices, then roast the chicken on '
              'top until golden.',
          'اطبخ الرز في الشوربة مع البهارات، وحمّر الفراخ فوقه في الفرن.',
        ),
        baseDuration: Duration(minutes: 35),
      ),
    ],
  ),
  Recipe(
    id: 'lamb-biryani',
    name: _T('Lamb Biryani', 'برياني لحمة'),
    description: _T(
      'Layers of spiced lamb and saffron basmati rice, slowly steamed '
          'together.',
      'طبقات من اللحمة المتبلة والرز البسمتي بالزعفران متسويين على البخار.',
    ),
    imageUrl: '$_img/xrttsx1487339558.jpg',
    tags: [_Tag.meat, _Tag.rice, _Tag.spicy],
    diet: DietType.meat,
    servings: 6,
    ingredients: [
      Ingredient(
        name: _T('Lamb pieces', 'لحمة ضاني'),
        quantity: _T('1 kg', 'كيلو'),
      ),
      Ingredient(
        name: _T('Basmati rice', 'رز بسمتي'),
        quantity: _T('3 cups', '٣ كوبايات'),
      ),
      Ingredient(name: _T('Yogurt', 'زبادي'), quantity: _T('1 cup', 'كوباية')),
      Ingredient(
        name: _T('Biryani spices', 'بهارات برياني'),
        quantity: _T('2 tbsp', '٢ معلقة كبيرة'),
      ),
      Ingredient(
        name: _T('Fried onions', 'بصل محمر'),
        quantity: _T('1 cup', 'كوباية'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Marinate the lamb', 'تتبيل اللحمة'),
        description: _T(
          'Marinate the lamb in yogurt and biryani spices.',
          'تبّل اللحمة بالزبادي وبهارات البرياني.',
        ),
        baseDuration: Duration(minutes: 15),
      ),
      RecipeStep(
        title: _T('Cook the lamb', 'تسوية اللحمة'),
        description: _T(
          'Cook the lamb with onions until tender and the sauce thickens.',
          'سوّي اللحمة مع البصل لحد ما تطرى والصوص يتقل.',
        ),
        baseDuration: Duration(minutes: 40),
      ),
      RecipeStep(
        title: _T('Par-boil the rice', 'سلق الرز نص سوا'),
        description: _T(
          'Boil the rice with whole spices until half cooked.',
          'اسلق الرز مع البهارات الصحيحة لحد ما ينص سوا.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Layer & steam', 'الرص والتسوية على البخار'),
        description: _T(
          'Layer rice over the lamb with saffron and fried onions, cover and '
              'steam.',
          'رص الرز فوق اللحمة مع الزعفران والبصل المحمر، غطّيها وسيبها على '
              'البخار.',
        ),
        baseDuration: Duration(minutes: 25),
      ),
    ],
  ),

  // ───────────────────────────── International ─────────────────────────────
  Recipe(
    id: 'tandoori-chicken',
    name: _T('Tandoori Chicken', 'فراخ تندوري'),
    description: _T(
      'Chicken marinated in yogurt and bold Indian spices, roasted until '
          'charred.',
      'فراخ متبلة بالزبادي والبهارات الهندي ومتحمرة لحد ما تتشوط.',
    ),
    imageUrl: '$_img/qptpvt1487339892.jpg',
    tags: [_Tag.chicken, _Tag.spicy, _Tag.grill],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Chicken legs', 'أوراك فراخ'),
        quantity: _T('8', '٨'),
      ),
      Ingredient(name: _T('Yogurt', 'زبادي'), quantity: _T('1 cup', 'كوباية')),
      Ingredient(
        name: _T('Tandoori masala', 'بهارات تندوري'),
        quantity: _T('3 tbsp', '٣ معالق كبيرة'),
      ),
      Ingredient(name: _T('Lemon', 'ليمون'), quantity: _T('1', 'واحدة')),
    ],
    steps: [
      RecipeStep(
        title: _T('Score & marinate', 'التشريح والتتبيل'),
        description: _T(
          'Score the chicken and coat with yogurt, lemon and tandoori masala.',
          'شرّح الفراخ وغطّيها بالزبادي والليمون وبهارات التندوري.',
        ),
        baseDuration: Duration(minutes: 15),
      ),
      RecipeStep(
        title: _T('Roast', 'التحمير'),
        description: _T(
          'Roast in a very hot oven or grill until cooked and charred.',
          'حمّرها في فرن سخن جدًا أو على الشواية لحد ما تستوي وتتشوط.',
        ),
        baseDuration: Duration(minutes: 30),
      ),
    ],
  ),
  Recipe(
    id: 'chicken-potato-curry',
    name: _T('Chicken & Potato Curry', 'فراخ بالكاري والبطاطس'),
    description: _T(
      'A warming curry of chicken and potatoes in a spiced onion and tomato '
          'gravy.',
      'كاري دافي بالفراخ والبطاطس في صوص بصل وطماطم متبل.',
    ),
    imageUrl: '$_img/9ya6o71780262651.jpg',
    tags: [_Tag.chicken, _Tag.potatoes, _Tag.spicy],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Chicken thighs', 'أوراك فراخ'),
        quantity: _T('700 g', '٧٠٠ جرام'),
      ),
      Ingredient(name: _T('Potatoes', 'بطاطس'), quantity: _T('3', '٣')),
      Ingredient(
        name: _T('Curry powder', 'كاري'),
        quantity: _T('2 tbsp', '٢ معلقة كبيرة'),
      ),
      Ingredient(
        name: _T('Onion & tomato', 'بصل وطماطم'),
        quantity: _T('2 each', '٢ من كل نوع'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Build the base', 'عمل الأساس'),
        description: _T(
          'Fry onions until golden, add garlic, ginger, curry and tomatoes.',
          'حمّر البصل، ضيف التوم والجنزبيل والكاري والطماطم.',
        ),
        baseDuration: Duration(minutes: 12),
      ),
      RecipeStep(
        title: _T('Add chicken & potatoes', 'إضافة الفراخ والبطاطس'),
        description: _T(
          'Add the chicken and potato chunks and stir to coat.',
          'ضيف الفراخ وقطع البطاطس وقلّب.',
        ),
        baseDuration: Duration(minutes: 5),
      ),
      RecipeStep(
        title: _T('Simmer', 'التسبيك'),
        description: _T(
          'Add water and simmer until the potatoes are soft.',
          'ضيف مية وسيبها لحد ما البطاطس تستوي.',
        ),
        baseDuration: Duration(minutes: 25),
      ),
    ],
  ),
  Recipe(
    id: 'beef-stroganoff',
    name: _T('Beef Stroganoff', 'بيف ستروجانوف'),
    description: _T(
      'Strips of beef and mushrooms in a creamy, tangy sauce.',
      'شرايح لحمة ومشروم في صوص كريمي.',
    ),
    imageUrl: '$_img/svprys1511176755.jpg',
    tags: [_Tag.meat, _Tag.sauce],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Beef fillet', 'لحمة فيليه'),
        quantity: _T('500 g', 'نص كيلو'),
      ),
      Ingredient(
        name: _T('Mushrooms', 'مشروم'),
        quantity: _T('250 g', '٢٥٠ جرام'),
      ),
      Ingredient(
        name: _T('Cooking cream', 'كريمة طبخ'),
        quantity: _T('200 ml', '٢٠٠ مل'),
      ),
      Ingredient(name: _T('Onion', 'بصل'), quantity: _T('1', 'واحدة')),
    ],
    steps: [
      RecipeStep(
        title: _T('Sear the beef', 'تحمير اللحمة'),
        description: _T(
          'Sear the beef strips quickly in batches and set aside.',
          'حمّر شرايح اللحمة بسرعة على دفعات وشيلها على جنب.',
        ),
        baseDuration: Duration(minutes: 6),
      ),
      RecipeStep(
        title: _T('Cook mushrooms', 'تشويح المشروم'),
        description: _T(
          'Sauté onion and mushrooms until golden.',
          'شوّح البصل والمشروم لحد ما يحمروا.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Make it creamy', 'الصوص الكريمي'),
        description: _T(
          'Add cream and mustard, return the beef and warm through.',
          'ضيف الكريمة والمسطردة ورجّع اللحمة وسخّنها.',
        ),
        baseDuration: Duration(minutes: 5),
      ),
    ],
  ),
  Recipe(
    id: 'beef-burger',
    name: _T('Classic Beef Burger', 'برجر لحمة'),
    description: _T(
      'Juicy homemade beef patties in toasted buns with cheese and all the '
          'toppings.',
      'برجر لحمة بيتي طري في عيش محمص مع الجبنة وكل الإضافات.',
    ),
    imageUrl: '$_img/44bzep1761848278.jpg',
    tags: [_Tag.meat, _Tag.bread, _Tag.grill],
    diet: DietType.meat,
    servings: 4,
    ingredients: [
      Ingredient(
        name: _T('Minced beef', 'لحمة مفرومة'),
        quantity: _T('600 g', '٦٠٠ جرام'),
      ),
      Ingredient(name: _T('Burger buns', 'عيش برجر'), quantity: _T('4', '٤')),
      Ingredient(
        name: _T('Cheddar slices', 'شرايح شيدر'),
        quantity: _T('4', '٤'),
      ),
      Ingredient(
        name: _T('Lettuce, tomato & onion', 'خس وطماطم وبصل'),
        quantity: _T('For topping', 'للإضافة'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Shape the patties', 'تشكيل البرجر'),
        description: _T(
          'Season the meat lightly and shape four patties.',
          'تبّل اللحمة خفيف وشكّلها ٤ أقراص.',
        ),
        baseDuration: Duration(minutes: 6),
      ),
      RecipeStep(
        title: _T('Grill', 'الشوي'),
        description: _T(
          'Grill 3-4 minutes per side, adding cheese at the end.',
          'اشويها ٣-٤ دقايق كل ناحية وحط الجبنة في الآخر.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Assemble', 'التجميع'),
        description: _T(
          'Toast the buns and build the burgers with toppings and sauce.',
          'حمّص العيش وركّب البرجر مع الإضافات والصوص.',
        ),
        baseDuration: Duration(minutes: 4),
      ),
    ],
  ),
  Recipe(
    id: 'kung-pao-chicken',
    name: _T('Kung Pao Chicken', 'فراخ كونج باو'),
    description: _T(
      'Spicy Sichuan stir fry of chicken, peanuts and chilies in a sweet, '
          'tangy sauce.',
      'فراخ صيني حار متشوح مع الفول السوداني والشطة في صوص حلو وحامض.',
    ),
    imageUrl: '$_img/1525872624.jpg',
    tags: [_Tag.chicken, _Tag.spicy, _Tag.sauce],
    diet: DietType.meat,
    servings: 3,
    ingredients: [
      Ingredient(
        name: _T('Chicken breast', 'صدور فراخ'),
        quantity: _T('500 g', 'نص كيلو'),
      ),
      Ingredient(
        name: _T('Roasted peanuts', 'فول سوداني محمص'),
        quantity: _T('1/2 cup', 'نص كوباية'),
      ),
      Ingredient(
        name: _T('Dried chilies', 'شطة ناشفة'),
        quantity: _T('6', '٦'),
      ),
      Ingredient(
        name: _T('Soy sauce & vinegar', 'صويا وخل'),
        quantity: _T('2 tbsp each', '٢ معلقة من كل نوع'),
      ),
    ],
    steps: [
      RecipeStep(
        title: _T('Prep', 'التجهيز'),
        description: _T(
          'Dice the chicken and mix the sauce ingredients.',
          'قطّع الفراخ مكعبات واخلط مكونات الصوص.',
        ),
        baseDuration: Duration(minutes: 8),
      ),
      RecipeStep(
        title: _T('Stir fry', 'التشويح'),
        description: _T(
          'Stir fry chilies, then chicken until cooked.',
          'شوّح الشطة وبعدين الفراخ لحد ما تستوي.',
        ),
        baseDuration: Duration(minutes: 7),
      ),
      RecipeStep(
        title: _T('Sauce & peanuts', 'الصوص والسوداني'),
        description: _T(
          'Pour in the sauce, toss with peanuts until glossy.',
          'صب الصوص وقلّب مع السوداني لحد ما يلمع.',
        ),
        baseDuration: Duration(minutes: 3),
      ),
    ],
  ),
];
