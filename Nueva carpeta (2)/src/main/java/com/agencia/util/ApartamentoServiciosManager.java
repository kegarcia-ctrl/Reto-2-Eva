package com.agencia.util;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

/**
 * Utility class to manage Many-to-Many relations manually if needed outside JPA
 * context.
 * Note: JPA's @ManyToMany automatically handles this in the database.
 */
public class ApartamentoServiciosManager {

    public static class ApartamentoServicio {
        private final int idApartamento;
        private final int idServicio;

        public ApartamentoServicio(int idApartamento, int idServicio) {
            this.idApartamento = idApartamento;
            this.idServicio = idServicio;
        }

        public int getIdApartamento() {
            return idApartamento;
        }

        public int getIdServicio() {
            return idServicio;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o)
                return true;
            if (!(o instanceof ApartamentoServicio))
                return false;
            ApartamentoServicio that = (ApartamentoServicio) o;
            return idApartamento == that.idApartamento && idServicio == that.idServicio;
        }

        @Override
        public int hashCode() {
            return Objects.hash(idApartamento, idServicio);
        }
    }

    private final Set<ApartamentoServicio> relations = new HashSet<>();

    public boolean addRelation(int idApartamento, int idServicio) {
        return relations.add(new ApartamentoServicio(idApartamento, idServicio));
    }

    public boolean removeRelation(int idApartamento, int idServicio) {
        return relations.remove(new ApartamentoServicio(idApartamento, idServicio));
    }

    public void removeByApartamento(int idApartamento) {
        relations.removeIf(rel -> rel.getIdApartamento() == idApartamento);
    }

    public void removeByServicio(int idServicio) {
        relations.removeIf(rel -> rel.getIdServicio() == idServicio);
    }

    public boolean relationExists(int idApartamento, int idServicio) {
        return relations.contains(new ApartamentoServicio(idApartamento, idServicio));
    }
}
