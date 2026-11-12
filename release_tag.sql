-- BAG.ID: bezpečné odstránenie NFC štítku z používateľského účtu.
-- Spusti v Supabase SQL Editor → New query PRED zlúčením novej webovej verzie.
-- Neprepisuje existujúce NFC tokeny ani aktivačné kľúče.
-- Rovnaký skript sa môže spustiť opakovane.

create or replace function public.release_bag_tag(p_tag_id uuid)
returns boolean
language plpgsql
security definer
set search_path = ''
as $$
declare
  actor_id uuid;
  removed boolean;
begin
  actor_id := (select auth.uid());
  if actor_id is null then
    return false;
  end if;

  update public.tags
    set owner_id = null,
        label = 'BAG.ID štítok',
        public_note = '',
        contact_email = '',
        share_enabled = false,
        is_active = false,
        updated_at = now()
  where id = p_tag_id and owner_id = actor_id;
  removed := found;
  return removed;
end;
$$;

revoke all on function public.release_bag_tag(uuid) from public;
revoke all on function public.release_bag_tag(uuid) from anon;
grant execute on function public.release_bag_tag(uuid) to authenticated;
