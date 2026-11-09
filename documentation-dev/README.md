# Documentation de développement

Journal de chaque modification faite par Claude Code sur le projet (Claude ne commit pas : ces fiches servent de trace pour les commits faits à la main).

## Règles

- Un fichier par modification (ou groupe de modifications liées).
- Nom : `YYYY-MM-DD-HH-MM_description-courte.md` (description en minuscules, mots séparés par des tirets).
- Les fichiers se trient donc chronologiquement.

## Modèle

```markdown
# <Titre court de la modification>

- **Date** : YYYY-MM-DD HH:MM
- **Branche** : feature/xx-...

## Fichiers modifiés ou créés

- `chemin/fichier` — créé | modifié | supprimé : ce qui a changé

## Raisons

Pourquoi cette modification a été faite.

## Agents utilisés

- Aucun | nom de l'agent : ce qu'il a fait

## Points d'attention / suite

- (optionnel) commandes à lancer, migrations, problèmes repérés
```
