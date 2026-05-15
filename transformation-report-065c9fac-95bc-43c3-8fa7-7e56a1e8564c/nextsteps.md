# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The solution build output contains no errors across all projects. The transformation to cross-platform .NET appears to have completed successfully.

## Validation

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
Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended modern .NET version (e.g., `net8.0`):

```xml
<TargetFramework>net8.0</TargetFramework>
```

If it is targeting an older version such as `net6.0` or `net7.0`, consider updating it to the current LTS release.

### 4. Run the Application Locally
Start the application and verify it runs without runtime errors:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Navigate through the application and exercise the primary workflows (e.g., browsing products, cart functionality, checkout) to catch any runtime issues that would not surface at build time.

### 5. Check for Removed or Changed APIs
Even with a clean build, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **File paths**: Ensure no hardcoded Windows-style paths (`\`) exist. Use `Path.Combine` where applicable.
- **Configuration**: Verify that `Web.config` transforms have been replaced with `appsettings.json` and that all connection strings and app settings are correctly migrated.
- **Authentication/Session**: Confirm that any Forms Authentication or Session state configuration has been replaced with the ASP.NET Core equivalents.
- **Entity Framework**: If the project uses Entity Framework, confirm it has been migrated from EF 6 to EF Core and that migrations are functioning correctly.

### 6. Run Existing Tests
If the solution contains test projects, execute them to validate core functionality:

```bash
dotnet test
```

Review any failing tests and address them individually, as they may indicate runtime behavioral differences introduced by the migration.

### 7. Database Validation
If the application uses a database:

- Verify the connection string in `appsettings.json` is correct for the target environment.
- Run any pending EF Core migrations:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

- Manually verify that data reads and writes function as expected.

### 8. Static Files and Middleware
Confirm that static files (CSS, JavaScript, images) are being served correctly. In ASP.NET Core, static files must reside in the `wwwroot` folder and `UseStaticFiles()` must be called in the middleware pipeline within `Program.cs` or `Startup.cs`.

### 9. Publish a Release Build
Once local validation is complete, produce a published output to confirm the release artifact is complete:

```bash
dotnet publish --configuration Release --output ./publish
```

Inspect the `./publish` directory to ensure all expected files, views, and static assets are present.