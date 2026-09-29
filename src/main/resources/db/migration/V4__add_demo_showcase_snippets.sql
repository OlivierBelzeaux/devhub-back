INSERT INTO snippets (id, title, content, language, description, visibility)
VALUES
    (
        '00000000-0000-0000-0000-000000000002',
        'Angular theme service with signals',
        'import { Injectable, signal } from ''@angular/core'';\n\n@Injectable({ providedIn: ''root'' })\nexport class ThemeService {\n  readonly isDark = signal(sessionStorage.getItem(''theme'') === ''dark'');\n\n  toggle(): void {\n    this.isDark.update(value => !value);\n    sessionStorage.setItem(''theme'', this.isDark() ? ''dark'' : ''light'');\n  }\n}',
        'typescript',
        'Keeps a light or dark theme choice in browser session storage with Angular signals.',
        'DEMO'
    ),
    (
        '00000000-0000-0000-0000-000000000003',
        'Angular API configuration with InjectionToken',
        'import { InjectionToken, inject } from ''@angular/core'';\n\nexport const API_URL = new InjectionToken<string>(''API_URL'');\n\nexport class SnippetApiService {\n  private readonly apiUrl = inject(API_URL);\n\n  list() {\n    return this.http.get(this.apiUrl + ''/snippets'');\n  }\n}',
        'typescript',
        'Injects the API base URL instead of hard-coding environment-specific values in services.',
        'DEMO'
    ),
    (
        '00000000-0000-0000-0000-000000000004',
        'Angular search state in query parameters',
        'this.router.navigate([''/demo''], {\n  queryParams: {\n    query: formValue.query || null,\n    language: formValue.language || null,\n    tag: formValue.tag || null\n  }\n});\n\nthis.route.queryParamMap.subscribe(params => {\n  this.search(params.get(''query'') ?? '''');\n});',
        'typescript',
        'Makes a filtered search shareable and restores it after a page reload.',
        'DEMO'
    ),
    (
        '00000000-0000-0000-0000-000000000005',
        'Consistent REST API errors with @RestControllerAdvice',
        '@RestControllerAdvice\nclass ApiExceptionHandler {\n\n  @ExceptionHandler(SnippetNotFoundException.class)\n  ResponseEntity<ApiError> handleNotFound(SnippetNotFoundException exception) {\n    return ResponseEntity.status(HttpStatus.NOT_FOUND)\n        .body(new ApiError(''SNIPPET_NOT_FOUND'', exception.getMessage()));\n  }\n}',
        'java',
        'Returns a predictable error payload for missing resources across the REST API.',
        'DEMO'
    ),
    (
        '00000000-0000-0000-0000-000000000006',
        'Spring Data pagination with Pageable',
        '@GetMapping\nPage<SnippetResponse> list(Pageable pageable) {\n  return snippetRepository.findByOwnerId(currentUser.id(), pageable)\n      .map(SnippetResponse::from);\n}\n\n// GET /api/snippets?page=0&size=20&sort=updatedAt,desc',
        'java',
        'Uses Spring Data pagination and sorting to keep a snippet list efficient and predictable.',
        'DEMO'
    );

INSERT INTO tags (id, name) VALUES
    ('00000000-0000-0000-0000-000000000021', 'angular'),
    ('00000000-0000-0000-0000-000000000022', 'signals'),
    ('00000000-0000-0000-0000-000000000023', 'theme'),
    ('00000000-0000-0000-0000-000000000024', 'http-client'),
    ('00000000-0000-0000-0000-000000000025', 'clean-code'),
    ('00000000-0000-0000-0000-000000000026', 'router'),
    ('00000000-0000-0000-0000-000000000027', 'search'),
    ('00000000-0000-0000-0000-000000000028', 'exception-handling'),
    ('00000000-0000-0000-0000-000000000029', 'rest-api'),
    ('00000000-0000-0000-0000-000000000030', 'spring-data'),
    ('00000000-0000-0000-0000-000000000031', 'pagination')
ON CONFLICT (name) DO NOTHING;

INSERT INTO snippet_tags (snippet_id, tag_id)
SELECT '00000000-0000-0000-0000-000000000002'::uuid, id FROM tags WHERE name IN ('angular', 'signals', 'theme')
UNION ALL
SELECT '00000000-0000-0000-0000-000000000003'::uuid, id FROM tags WHERE name IN ('angular', 'http-client', 'clean-code')
UNION ALL
SELECT '00000000-0000-0000-0000-000000000004'::uuid, id FROM tags WHERE name IN ('angular', 'router', 'search')
UNION ALL
SELECT '00000000-0000-0000-0000-000000000005'::uuid, id FROM tags WHERE name IN ('spring-boot', 'exception-handling', 'rest-api')
UNION ALL
SELECT '00000000-0000-0000-0000-000000000006'::uuid, id FROM tags WHERE name IN ('spring-boot', 'spring-data', 'pagination');
