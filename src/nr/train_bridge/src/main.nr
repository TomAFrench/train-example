use aztec::protocol_types::traits::Packable;

use aztec::state_vars::SharedMutable;

// mod shared_mutable;
// use shared_mutable::SharedMutable;

#[derive(Eq, Packable)]
pub struct HTLC_Public {
    src_receiver: Field,
    amount: Field,
}

#[storage]
pub struct Storage<Context> {
    contracts_public: SharedMutable<HTLC_Public, 180, Context>,
}

comptime fn storage(s: TypeDefinition) -> Quoted {
    for field in s.fields_as_written() {
        // FIXME: This doesn't handle field types with generics
        let (_, typ, _) = field;
        let storage_size = std::meta::typ::fresh_type_variable();
        assert(
            typ.implements(quote { dep::aztec::state_vars::Storage<$storage_size> }
                .as_trait_constraint()),
            f"Attempted to fetch storage size, but {typ} does not implement the Storage trait",
        );
    }
    quote {}
}
