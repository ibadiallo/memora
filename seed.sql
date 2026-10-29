-- MEMORA — initial data. Run after schema.sql (SQL Editor → New query → paste → Run)
-- Image paths point to the images/ folder of the site; replace them with Storage URLs if you move photos to Supabase.

insert into public.products (slug, name, type, price, image, hover_image, gallery, sizes, colors, in_stock, description_fr, description_en, featured, sort_order) values
('voile-kheira', 'Voile Kheira', 'Voile', 6000, 'images/products/voile-kheira-1.jpg', 'images/products/voile-kheira-2.jpg', null, null, null, true, null, null, true, 10),
('jannah', 'Jannah', 'Abaya', 65000, 'images/products/jannah-1.jpg', 'images/products/jannah-2.jpg', array['images/products/jannah-1.jpg','images/products/jannah-3.jpg'], '{54}', array['Jaune ambré'], false, 'Découvrez l’Abaya Jannah, une pièce rare et exclusive dont le nom évoque le Paradis.
Confectionnée dans un tissu noble aux reflets dorés et au tombé fluide, elle est ornée d’une guipure de dentelle blanche florale qui rappelle la pureté et la beauté d’un jardin céleste. Sa coupe élégante et ses manches larges en font une tenue d’exception pour vos événements les plus marquants.', 'Discover the Jannah Abaya, a rare and exclusive piece whose name evokes Paradise.
Made from a noble fabric with golden highlights and a fluid drape, it is adorned with white floral lace guipure that recalls the purity and beauty of a heavenly garden. Its elegant cut and wide sleeves make it an exceptional outfit for your most memorable occasions.', true, 20),
('that-girl', 'That Girl', 'Abaya', 29900, 'images/products/that-girl-1.jpg', 'images/products/that-girl-2.jpg', null, null, null, true, null, null, true, 30),
('salama', 'Salama', 'Abaya', 35000, 'images/products/salama-1.jpg', 'images/products/salama-2.jpg', null, null, null, true, null, null, true, 40),
('princess', 'Princess', 'Abaya', 29900, 'images/products/princess-1.jpg', 'images/products/princess-2.jpg', null, null, null, true, null, null, true, 50),
('nafis', 'Nafis', 'Abaya', 30000, 'images/products/nafis-1.jpg', 'images/products/nafis-2.jpg', null, null, null, true, null, null, true, 60),
('zahira', 'Zahira', 'Abaya', 65000, 'images/products/zahira-1.jpg', 'images/products/zahira-2.jpg', null, null, null, true, null, null, false, 70),
('floral', 'Floral', 'Abaya', 149000, 'images/products/floral-1.jpg', 'images/products/floral-2.jpg', null, null, null, true, null, null, false, 80),
('eden', 'Eden', 'Abaya', 29900, 'images/products/eden-1.jpg', 'images/products/eden-2.jpg', null, null, null, true, null, null, false, 90),
('evy', 'Evy', 'Abaya', 35000, 'images/products/evy-1.jpg', 'images/products/evy-2.jpg', null, null, null, true, null, null, false, 100)
on conflict (slug) do nothing;

insert into public.editorial_slides (image, sort_order)
select v.image, v.sort_order from (values
  ('images/editorial/1.jpg', 10),
  ('images/editorial/2.jpg', 20),
  ('images/editorial/3.jpg', 30),
  ('images/editorial/4.jpg', 40)
) as v(image, sort_order)
where not exists (select 1 from public.editorial_slides);

-- Fill in when you have the texts:
-- insert into public.site_info (key, fr, en) values
--   ('care',     '...', '...'),
--   ('delivery', '...', '...');
