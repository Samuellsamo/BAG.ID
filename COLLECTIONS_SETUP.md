# BAG.ID – zdieľateľné kolekcie vo Favorite Spots

Toto je samostatné rozšírenie existujúcej webovej aplikácie. Nevymazáva účty, NFC štítky ani obľúbené miesta.

## Inštalácia
1. Otvor Supabase **SQL Editor → New query**.
2. Skopíruj celý obsah súboru **collections.sql**, klikni **Run** a skontroluj **Success**. SQL spusti iba raz (politiky sa pri opakovanom spustení nevytvoria druhýkrát).
3. Na GitHube otvor návrh zmien (Pull Request) a po úspešnom SQL ho zlúč do vetvy **main**.
4. Po deployi na GitHub Pages obnov stránku cez Ctrl+Shift+R.
5. Prihlás sa, otvor **Favorite Spots**, vytvor kolekciu a pridávaj do nej miesta z Favorites.

## Zdieľanie
- Nová kolekcia je **súkromná**.
- **Zapnúť zdieľanie** vytvorí prístup pre každého, kto má náhodný odkaz.
- **Kopírovať odkaz** umožní poslať ju aj ľuďom bez účtu BAG.ID.
- **Vypnúť zdieľanie** ihneď zneprístupní verejný obsah (okrem predtým uložených kópií).
- **Zmeniť zdieľaný odkaz** zneplatní starý odkaz.
- Súčasťou kolekcie sú názvy miest a ich polohy; nikdy nezdieľaj miesto, ktoré nechceš ukázať ostatným.
- Zdieľaná kolekcia nezobrazuje meno, e-mail ani iné profilové údaje vlastníka.

## Test
- Vytvor aspoň jednu obľúbenú položku a kolekciu.
- Pridaj miesto, povoľ zdieľanie, skopíruj URL a otvor ju v anonymnom okne.
- Vypni zdieľanie a znova otvor link v anonymnom okne. Obsah sa už nemá zobraziť.
- Vytvor druhý účet a over, že cudzie kolekcie sa nezobrazujú vo Favorites.
- Otestuj tlačidlo **Zmeniť zdieľaný odkaz** a starý link.

**Nasadenie je potrebné otestovať s aktívnym Supabase projektom.** Zmeny sú pripravené vo vetve PR, živý web ostáva bezo zmeny, kým PR neschváliš.
