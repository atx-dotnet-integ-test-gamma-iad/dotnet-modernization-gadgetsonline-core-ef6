# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The solution build output contains no errors for the transformed project (`GadgetsOnline/GadgetsOnline.csproj`). This indicates the migration to cross-platform .NET has completed without any compilation issues.

## Validation Steps

### 1. Restore and Build the Solution

Run the following commands from the solution root to confirm a clean restore and build:

```bash
dotnet restore
dotnet build --configuration Release
```

Verify that the output reports `0 Error(s)` and `0 Warning(s)` (or review any remaining warnings for potential runtime issues).

### 2. Review Project File

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the following:

- The `<TargetFramework>` element targets a supported cross-platform .NET version (e.g., `net8.0` or `net6.0`).
- Any previously Windows-specific NuGet packages (e.g., `System.Web`, legacy ASP.NET packages) have been replaced with their cross-platform equivalents.
- No `<Reference>` elements point to GAC assemblies or absolute Windows paths.

### 3. Run the Application Locally

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Navigate to the application in a browser and exercise the primary workflows (product listing, cart, checkout, etc.) to confirm runtime behavior matches the legacy version.

### 4. Execute the Test Suite

If a test project exists in the solution, run:

```bash
dotnet test --configuration Release --logger "console;verbosity=detailed"
```

Review the output for any failing tests that may indicate behavioral regressions introduced during migration.

### 5. Verify Database Connectivity

If the application uses Entity Framework or direct ADO.NET connections:

- Confirm the connection string in `appsettings.json` (or `appsettings.Production.json`) is correct for the target environment.
- Run any pending migrations:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

- Manually test data read and write operations through the application UI.

### 6. Check Static Files and Middleware Configuration

- Confirm that `app.UseStaticFiles()` is present in the middleware pipeline (`Program.cs` or `Startup.cs`) so that CSS, JavaScript, and image assets are served correctly.
- Browse to known static asset URLs and verify they return `200 OK`.

### 7. Cross-Platform Smoke Test

If the goal is to run on Linux or macOS, execute the above `dotnet run` step on the target operating system and verify:

- File path separators do not cause issues (avoid hardcoded `\` paths in code).
- Any file I/O operations use `Path.Combine` rather than string concatenation.
- No remaining `[DllImport]` calls reference Windows-only native libraries.

### 8. Review Application Logs

Run the application and inspect the console or log output for any runtime exceptions, deprecation warnings, or missing configuration values that were not surfaced at compile time.

## Deployment

Once all validation steps above pass:

1. Publish a self-contained or framework-dependent release build:

```bash
dotnet publish GadgetsOnline/GadgetsOnline.csproj \
    --configuration Release \
    --output ./publish
```

2. Copy the contents of `./publish` to the target server.
3. Ensure the target server has the matching .NET runtime installed (if using a framework-dependent deployment).
4. Start the application using the appropriate host (e.g., Kestrel directly, or behind a reverse proxy such as Nginx or IIS).