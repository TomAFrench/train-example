use dep::aztec::protocol_types::{shared_mutable::SharedMutableValues, traits::Packable};

use aztec::{state_vars::storage::Storage, utils::with_hash::WithHash};

pub struct SharedMutable<T, let INITIAL_DELAY: u64, Context> {
    context: Context,
    storage_slot: Field,
}

// This will make the Aztec macros require that T implements the Packable and Eq traits, and allocate `M` storage
// slots to this state variable.
impl<T, let INITIAL_DELAY: u64, Context, let M: u32> Storage<M> for SharedMutable<T, INITIAL_DELAY, Context>
where
    WithHash<SharedMutableValues<T, INITIAL_DELAY>, _>: Packable<M>,
{
    fn get_storage_slot(self) -> Field {
        self.storage_slot
    }
}
