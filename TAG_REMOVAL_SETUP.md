# BAG.ID – Odstránenie štítku z My Tags

## Čo sa stane
- V My Tags pribudne **Odstrániť štítok z My Tags** pri každom tvojom štítku.
- Pred odstránením sa zobrazí potvrdenie.
- V databáze sa overí, že daný štítok patrí práve prihlásenému používateľovi.
- Vlastník sa odpojí, štítok sa deaktivuje, kontakt a verejná správa sa vymažú.
- **Fyzický NFC čip a jeho jedinečný odkaz zostanú existovať**, ale prestanú odhaľovať súkromné údaje.
- Pôvodný aktivačný kľúč zostane platný, takže s ním môžeš štítok znova pridať v My Tags.

## Inštalácia
1. V Supabase otvor **SQL Editor → New query**.
2. Skopíruj celý obsah súboru **release_tag.sql** a klikni na **Run**.
3. Po výsledku **Success** otvor Pull Request a zluč ho cez **Merge pull request**.
4. Po chvíli otvor BAG.ID a obnov ho pomocou **Ctrl + Shift + R**.

## Test
1. Aktivuj testovací štítok a over, že sa zobrazuje v My Tags.
2. Zapni zdieľanie, otvor NFC odkaz v anonymnom okne, over správu a (ak si vyplnil) kontakt.
3. Odstráň štítok cez My Tags a potvrď.
4. Over, že zmizol zo zoznamu a NFC odkaz **už nezobrazuje kontakt**.
5. S pôvodným aktivačným kľúčom ho znova pridaj do účtu.
6. Over, že nový cudzí účet nevie odstrániť tvoj štítok.

Skript spusti pred zlúčením PR, inak bude tlačidlo hlásiť nedostupnú databázovú funkciu.
