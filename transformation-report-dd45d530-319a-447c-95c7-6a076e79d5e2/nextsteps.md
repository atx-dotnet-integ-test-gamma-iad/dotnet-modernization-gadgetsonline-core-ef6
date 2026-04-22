# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

### 2. Build the Solution

Perform a full build to confirm the error-free state is consistent across all configurations:

```bash
dotnet build --configuration Debug
dotnet build --configuration Release
```

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended modern .NET version (e.g., `net8.0`). Example:

```xml
<PropertyGroup>
  <TargetFramework>net8.0</TargetFramework>
</PropertyGroup>
```

### 4. Run the Application Locally

Start the application and verify it runs as expected:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Check the console output for any runtime exceptions or middleware configuration errors that would not surface at compile time.

### 5. Execute the Test Suite

If the solution contains test projects, run all tests to validate functional correctness:

```bash
dotnet test
```

Review any failing tests and determine whether they are caused by behavioral differences in the new runtime or by incomplete migration of specific features.

### 6. Verify Static Assets and Views

If this is a web application, navigate through the key pages in a browser and confirm:

- Static files (CSS, JavaScript, images) are served correctly.
- Razor views or Blazor components render without errors.
- Any bundling or minification pipelines (e.g., `libman`, `npm`) still function correctly.

### 7. Check Runtime Configuration

Review `appsettings.json` and `appsettings.Development.json` to confirm:

- Connection strings are valid and point to accessible data sources.
- Any environment-specific settings have been carried over from the legacy `Web.config` or `App.config`.

### 8. Database and Data Access Validation

If the project uses Entity Framework or another ORM:

- Run `dotnet ef migrations list` to confirm migration history is intact.
- Apply any pending migrations to a development database:

```bash
dotnet ef database update
```

- Perform basic CRUD operations through the application to verify data access works correctly.

### 9. Publish a Release Build

Once local validation is complete, produce a published output to confirm the release artifact is generated without issues:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all required files, including runtime dependencies and static assets, are present.